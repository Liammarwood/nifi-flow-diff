#!/bin/bash

set -euo pipefail

CHANGELOG="CHANGELOG.txt"
IMAGE_NAME="nifi-flow-diff"

# Detect default branch from origin
DEFAULT_BRANCH=$(git remote show origin | awk '/HEAD branch/ {print $NF}')
echo "Detected default branch: $DEFAULT_BRANCH"

# Detect container runtime (Docker or Podman)
if command -v docker &>/dev/null; then
  CONTAINER_CMD="docker"
elif command -v podman &>/dev/null; then
  CONTAINER_CMD="podman"
else
  echo "Error: Neither Docker or Podman is installed."
  exit 1
fi

echo "Using container runtime: $CONTAINER_CMD"

# Clear or create changelog file
echo "==== Generated NiFi Flow Changelog ====" > "$CHANGELOG"

# Process each .json file in the current directory
for file in *.json; do
  if git show "$DEFAULT_BRANCH:$file" &>/dev/null; then
    echo "Comparing $file to $DEFAULT_BRANCH..."

    MAIN_FILE=$(mktemp --suffix=.json)
    CURR_FILE=$(mktemp --suffix=.json)

    git show "$DEFAULT_BRANCH:$file" > "$MAIN_FILE"
    cp "$file" "$CURR_FILE"

    # Run flow diff via container
    DIFF_OUTPUT=$($CONTAINER_CMD run --rm \
      -v "$MAIN_FILE":/old.json:ro,Z \
      -v "$CURR_FILE":/new.json:ro,Z \
      "$IMAGE_NAME" /old.json /new.json)

    if [ -n "$DIFF_OUTPUT" ]; then
      {
        echo "==== Changelog for $file ===="
        echo "$DIFF_OUTPUT"
        echo ""
      } >> "$CHANGELOG"
    fi

    rm "$MAIN_FILE" "$CURR_FILE"
  else
    echo "Skipping $file (not in $DEFAULT_BRANCH)"
  fi
done

echo "Changelog written to $CHANGELOG"