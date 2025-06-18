#!/bin/bash
set -euo pipefail

READ1="$1"
READ2="$2"
INDEX="$3"
OUTBAM="$4"

ACCESSION=$(basename "$OUTBAM" .bam)

echo "Mapping $ACCESSION"

# Load modules
module purge
module load GCC/11.3.0
module load OpenMPI/4.1.4
module load HISAT2/2.2.1
module load SAMtools/1.16.1
module load deepTools/3.5.2

# Map reads
hisat2 -x "$INDEX" --rna-strandness FR -1 "$READ1" -2 "$READ2" -p 4 -S "${OUTBAM%.bam}.sam"

# Convert to BAM and clean up
samtools sort -O bam -o "$OUTBAM" "${OUTBAM%.bam}.sam"
rm "${OUTBAM%.bam}.sam"

# Index
samtools index -c "$OUTBAM"

# Bigwig
bamCoverage --bam "$OUTBAM" -o "${OUTBAM%.bam}.bw" -of bigwig --normalizeUsing RPKM --binSize=10
