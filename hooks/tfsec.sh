#!/usr/bin/env bash

set -eo pipefail

echo "========= START SCRIPT ==========="
echo "$@"
echo "======== end args ================"

directories=()
for arg in "$@"; do
  if [ -d "$arg" ]; then
    directories+=("$arg")
  else
    directories+=("$(dirname "$arg")")
  fi
done

# mapfile -t uniq_dirs < <(printf "%s\n" "${directories[@]}" | sort -u)
# read -a uniq_dirs = $(printf "%s\n" "${directories[@]}" | sort -u)
# uniq_dirs=()
# printf "%s\n" "${directories[@]}" | sort -u | while IFS="" read -r line; do uniq_dirs+=("$line"); done
uniq_dirs=($(printf "%s\n" "${directories[@]}" | sort -u))

echo "========= START SCAN ==========="
echo "${uniq_dirs[@]}"
echo "======== end dirs =============="

for d in "${uniq_dirs[@]}"; do
  echo "RUN ON DIR: $d"
  echo "======="
  if [ "$d" = "." ]; then
    echo "RUN ON DIR SKIP: $d"
    continue
  fi
  tfsec "$d"
done
