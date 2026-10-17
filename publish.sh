#!/usr/bin/env bash
# Push this README repository and publish a game build as a GitHub Release (binaries only).
#
#   ./publish.sh                         # version from the newest release-notes/v*.md
#   ./publish.sh 0.3.0-alpha.2           # a given version (needs release-notes/v<version>.md)
#   BUILD_DIR=path/to/build ./publish.sh # where the zips are (default: ../gadot-demo/build)
#   REPO=owner/name ./publish.sh         # target repository (default: from `git remote origin`)
#
# Needs: push access to the remote (SSH or HTTPS) and `gh auth login` done once.
# The zips are made by gadot-demo/tools/export_builds.sh:
#   Wildbound-<version>-macos.zip, Wildbound-<version>-windows-x64.zip
set -euo pipefail

# everything relative to this script, so it runs from any checkout on any machine
HERE=$(cd "$(dirname "$0")" && pwd)
cd "$HERE"

# version: the argument, else the newest release notes
if [ $# -ge 1 ]; then
	VERSION=$1
else
	latest=$(ls release-notes/v*.md 2>/dev/null | sort -V | tail -n 1 || true)
	[ -n "$latest" ] || { echo "error: no release-notes/v*.md, pass a version" >&2; exit 1; }
	VERSION=$(basename "$latest" .md)
	VERSION=${VERSION#v}
fi
TAG="v${VERSION}"
NOTES="release-notes/${TAG}.md"

# repository: $REPO, else owner/name from the origin remote (git@github.com:o/n.git or https://github.com/o/n)
if [ -z "${REPO:-}" ]; then
	url=$(git remote get-url origin 2>/dev/null || true)
	[ -n "$url" ] || { echo "error: no 'origin' remote; set REPO=owner/name" >&2; exit 1; }
	REPO=$(printf '%s\n' "$url" | sed -E 's#^(git@[^:]+:|https?://[^/]+/)##; s#\.git$##')
fi

# the builds: $BUILD_DIR, else the game project next to this repository
BUILD_DIR=${BUILD_DIR:-"$HERE/../gadot-demo/build"}
MAC="${BUILD_DIR}/Wildbound-${VERSION}-macos.zip"
WIN="${BUILD_DIR}/Wildbound-${VERSION}-windows-x64.zip"

for f in "$NOTES" "$MAC" "$WIN"; do
	[ -f "$f" ] || { echo "error: missing $f" >&2; exit 1; }
done
command -v gh >/dev/null 2>&1 || { echo "error: GitHub CLI 'gh' not installed (https://cli.github.com)" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "error: run 'gh auth login' first" >&2; exit 1; }

echo "repo $REPO, release $TAG"
echo "  $MAC"
echo "  $WIN"

git push -u origin main

if gh release view "$TAG" --repo "$REPO" >/dev/null 2>&1; then
	echo "release $TAG already exists: uploading the zips again (replacing same-named files)"
	gh release upload "$TAG" "$MAC" "$WIN" --repo "$REPO" --clobber
else
	TITLE="Wildbound 荒野归途 ${VERSION}"
	PRE=""
	case "$VERSION" in
		*-alpha*) TITLE="${TITLE}（Alpha 试玩）"; PRE="--prerelease" ;;
		*-beta*) TITLE="${TITLE}（Beta 测试）"; PRE="--prerelease" ;;
		*-rc*) TITLE="${TITLE}（候选版）"; PRE="--prerelease" ;;
		*-*) PRE="--prerelease" ;;
	esac
	# shellcheck disable=SC2086 # PRE is one flag or nothing
	gh release create "$TAG" "$MAC" "$WIN" \
		--repo "$REPO" \
		--target main \
		--title "$TITLE" \
		--notes-file "$NOTES" \
		$PRE
fi
echo "done: https://github.com/${REPO}/releases/tag/${TAG}"
