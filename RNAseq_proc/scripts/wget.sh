#!/bin/bash

# Input from Snakemake
ACCESSION=$(basename "$1")
OUTDIR=$(dirname "$1")

mkdir -p "$OUTDIR"
wget -O "$OUTDIR/$ACCESSION" "https://sra-pub-run-odp.s3.amazonaws.com/sra/$ACCESSION/$ACCESSION"

