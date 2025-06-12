#!/bin/bash
# Usage: fetch_genome.sh <datasets_cli_path> <accession> <output_zip>

set -e

DATASETS=$1
ACCESSION=$2
OUTZIP=$3

"./$DATASETS" download genome accession "$ACCESSION" --include genome,gff3 --filename "$OUTZIP" --no-progressbar

