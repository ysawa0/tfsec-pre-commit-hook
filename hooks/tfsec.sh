#!/usr/bin/env bash

set -e

export PATH=$PATH:/usr/local/bin

echo "========= START SCRIPT ==========="
echo "$@"

directories=()
for arg in "$@"; do
  echo "analyze $arg"
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
  if [ "$d" = "." ]; then
    continue
  fi
  tfsec "$d"
done
