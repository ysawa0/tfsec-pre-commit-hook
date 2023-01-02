#!/usr/bin/env bash

set -e

export PATH=$PATH:/usr/local/bin

directories=()
for file in "$@"; do
  if [ -d "$file" ]; then
    directories+=("$file")
  else
    directories+=("$(dirname "$file")")
  fi
done

unique_directories=$(printf "%s\n" "${directories[@]}" | sort -u)
unique_directories=("$unique_directories")

echo "========= START SCAN ==========="

for d in "${unique_directories[@]}"; do
  if [ "$d" = "." ]; then
    continue
  fi
  tfsec "$d"
done
