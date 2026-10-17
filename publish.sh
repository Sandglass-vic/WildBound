#!/usr/bin/env bash
# Push this README repository and publish a game build as a GitHub Release (binaries only).
#
#   ./publish.sh                    # v0.3.0-alpha.1
#   ./publish.sh 0.3.0-alpha.2      # another version (needs release-notes/v<version>.md)
#
# Needs: SSH access to github.com and `gh auth login` done once.
# The zips come from ../gadot-demo/build (gadot-demo/tools/export_builds.sh).
set -euo pipefail

cd "$(dirname "$0")"
VERSION=${1:-0.3.0-alpha.1}
TAG=v$VERSION
REPO=Sandglass-vic/WildBound
BUILD=../gadot-demo/build
NOTES=release-notes/$TAG.md
MAC=$BUILD/Wildbound-$VERSION-macos.zip
WIN=$BUILD/Wildbound-$VERSION-windows-x64.zip

for f in "$NOTES" "$MAC" "$WIN"; do
	[ -f "$f" ] || { echo "error: missing $f" >&2; exit 1; }
done
gh auth status >/dev/null 2>&1 || { echo "error: run 'gh auth login' first" >&2; exit 1; }

git push -u origin main

PRE=()
[[ $VERSION == *-* ]] && PRE=(--prerelease)
TITLE="Wildbound 荒野归途 $VERSION"
[[ $VERSION == *-alpha* ]] && TITLE="$TITLE（Alpha 试玩）"
gh release create "$TAG" "$MAC" "$WIN" \
	--repo "$REPO" \
	--target main \
	--title "$TITLE" \
	--notes-file "$NOTES" \
	"${PRE[@]}"
