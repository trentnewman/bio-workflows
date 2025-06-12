#!/bin/bash
# Usage: unzip_and_arrange.sh <zipfile> <accession> <output_dir> <done_flag>

set -e

ZIPFILE=$1
ACCESSION=$2
OUTDIR=$3
DONE_FLAG=$4

unzip "$ZIPFILE"
mkdir -p "$OUTDIR"
mv "ncbi_dataset/data/$ACCESSION"/* "$OUTDIR"/
rm -r ncbi_dataset README.md "$ZIPFILE"
rm -f md5sum.txt
touch "$DONE_FLAG"



