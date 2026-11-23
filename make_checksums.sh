#!/usr/bin/env bash
# Regenerates SHA256SUMS for every tracked file except the checksum file itself.
set -euo pipefail
cd "$(dirname "$0")"
find . -type f ! -path './.git/*' ! -name SHA256SUMS ! -name '*.zip' -print0 \
  | sort -z | xargs -0 sha256sum > SHA256SUMS
echo "Wrote SHA256SUMS ($(wc -l < SHA256SUMS) files)"
echo "Pre-registration hashes (compare with the paper):"
grep -iE 'prereg' SHA256SUMS || echo "  (no pre-registration files found yet)"
