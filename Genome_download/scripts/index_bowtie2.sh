#!/bin/bash
# Usage: index_bowtie2.sh <genome_dir> <done_flag>

set -e

GENOME_DIR=$1
OUTFLAG=$2

module load GCC/11.3.0
module load Bismark/0.24.0
module load Bowtie2/2.4.5

FASTA=$(find "$GENOME_DIR" -name "*.fna" | head -n 1)
PREFIX="${FASTA%.fna}"  # remove .fna extension for output prefix

bowtie2-build -f "$FASTA" "$PREFIX"

touch "$OUTFLAG"
