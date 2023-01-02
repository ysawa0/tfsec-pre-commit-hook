#!/usr/bin/env bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
echo "========= START SCRIPT =========== $SCRIPT_DIR"
echo "$@"
echo "======== end args ==="
# echo "$SCRIPT_DIR"

directories=()
for arg in "$@"; do
  # echo "analyze $arg"
  if [ -d "$arg" ]; then
    directories+=("$arg")
  else
    directories+=("$(dirname "$arg")")
  fi
done

unique_directories=$(printf "%s\n" "${directories[@]}" | sort -u)
unique_directories=("$unique_directories")

echo "========= START SCAN ==========="

for d in "${unique_directories[@]}"; do
  echo "RUN ON DIR: $d"
  echo "======="
  if [ "$d" = "." ]; then
    echo "RUN ON DIR SKIP: $d"
    continue
  fi
  tfsec "$d"
done
