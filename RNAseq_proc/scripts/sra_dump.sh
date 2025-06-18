#!/bin/bash
set -euo pipefail

# Input from Snakemake
SRA_PATH="$1"  # Full path to downloaded SRA file (e.g. ../../SRR10054149/SRR10054149)
ACCESSION=$(basename "$SRA_PATH")
OUTDIR=$(dirname "$SRA_PATH")

echo "Dumping FASTQ for $ACCESSION"

# Load modules (adjust these if needed)
module purge
module load GCC/11.3.0
module load OpenMPI/4.1.4
module load SRA-Toolkit/3.0.5

# Create output directory (if not already)
mkdir -p "$OUTDIR"

# Convert to FASTQ
fasterq-dump --split-files --outdir "$OUTDIR" "$SRA_PATH"

