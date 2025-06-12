#!/bin/bash
# Usage: download_ncbi_cli.sh <output_path>

set -e

OUTFILE=$1
OUTDIR=$(dirname "$OUTFILE")

mkdir -p "$OUTDIR"  # ensure the directory exists
curl -sSL -o "$OUTFILE" 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'
chmod +x "$OUTFILE"

