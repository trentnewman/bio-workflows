#!/bin/bash
set -euo pipefail

# Input from Snakemake
READ1="$1"  # e.g. ../../SRR10066842/SRR10066842_1.fastq
READ2="$2"  # e.g. ../../SRR10066842/SRR10066842_2.fastq

ACCESSION=$(basename "$READ1" _1.fastq)
OUTDIR=$(dirname "$READ1")

echo "Trimming $ACCESSION"

# Load modules
module purge
module load GCCcore/11.3.0
module load Trim_Galore/0.6.10

# Run trim_galore
trim_galore --paired --output_dir "$OUTDIR" "$READ1" "$READ2"

