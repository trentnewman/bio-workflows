#!/bin/bash
# Usage: index_hisat2.sh <genome_dir> <done_flag>

set -e

GENOME_DIR=$1
OUTFLAG=$2

module load GCC/11.3.0
module load HISAT2/2.2.1

FASTA=$(find "$GENOME_DIR" -name "*.fna" | head -n 1)
PREFIX="${FASTA%.fna}"  # removes .fna extension

hisat2-build "$FASTA" "$PREFIX"

touch "$OUTFLAG"

