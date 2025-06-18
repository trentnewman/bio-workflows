# bio-workflows

This repository contains modular, script-backed bioinformatics workflows managed with [Snakemake](https://snakemake.readthedocs.io/). Each workflow is self-contained and designed to be reusable and adaptable across different genomics tasks.

## Available Workflows

### 🧬 `Genome_download/`

Downloads, unpacks, and indexes a genome from NCBI using a given accession number.  
The workflow performs the following steps:

- Downloads the genome using the NCBI datasets CLI
- Extracts and arranges genome files
- Indexes the genome with both **Bowtie2** and **HISAT2**

### 🔧 Configuration

Set the accession number in `Genome_download/config.yaml`:

```yaml
accession: GCF_XXXXXXXXX.X
```

This will generate a genome directory outside the repository root, named after the accession (e.g. `GCF_XXXXXXXXX.X/`).

### 🚀 Running the Workflow

From within the `Genome_download/` directory:

```bash
sbatch submit_snake.slurm
```

This has been tested on the **Spartan HPC** system and may require modification of the SLURM script or module loading commands for other environments.

---

### 🧪 `RNAseq_proc/`

Processes paired-end RNA-seq data to produce aligned, indexed, and coverage-normalised files.  
The workflow performs the following steps:

- Trims reads with **Trim Galore**
- Aligns reads to a reference genome using **HISAT2**
- Sorts and indexes BAM files with **SAMtools**
- Generates a **BigWig** coverage track using **deepTools**

The workflow is modular and includes a script-based mapping step. Outputs include:

- `*.bam` — coordinate-sorted alignments  
- `*.bam.csi` — index for BAM  
- `*.bw` — RPKM-normalised coverage track

#### 🔧 Configuration

Set sample and genome information in `RNAseq_proc/config.yaml`:

```yaml
accession: SRRXXXXXXX               # RNA-seq sample accession
genome_accession: GCF_XXXXXXXXX.X   # Genome directory name
genome_name: GCF_XXXXXXXXX.X_genomic_prefix  # Index prefix basename
```

All outputs are written outside the repository under a directory named after the sample accession.

#### 🚀 Running the Workflow

From within the `RNAseq_proc/` directory:

```bash
sbatch submit_snake.slurm
```

---

## Notes

- All workflow outputs are written outside the repository (in parallel directories) to keep version control clean.
- Shell scripts used in each workflow are located in the `scripts/` subdirectory.
- This project assumes basic familiarity with HPC systems, SLURM, and module environments.

---

## 🔭 Roadmap

Additional workflows may be added over time, each in their own subdirectory under this repository.

---

## Author

Trent Newman
