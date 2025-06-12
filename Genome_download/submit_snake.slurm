#!/bin/bash
#SBATCH --job-name=genome_download
#SBATCH --output=./log/genome_download.out
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem=100G

module load OpenMPI/4.1.4
module load GCC/11.3.0
module load snakemake/8.4.2-Python-3.11.3

snakemake -s genome_download.smk --unlock || true
snakemake -s genome_download.smk --cores 1

