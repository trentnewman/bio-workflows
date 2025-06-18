#!/bin/bash
#SBATCH --job-name=rnaseq_proc
#SBATCH --output=./log/rnaseq_proc.out
#SBATCH --ntasks=1
#SBATCH --time=5:00:00
#SBATCH --mem=100G

module load OpenMPI/4.1.4
module load GCC/11.3.0
module load snakemake/8.4.2-Python-3.11.3

snakemake -s rnaseq_proc.smk --unlock || true
snakemake -s rnaseq_proc.smk --cores 1

