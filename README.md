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

## Notes

- All workflow outputs are written outside the repository (in parallel directories) to keep version control clean.
- Shell scripts used in each workflow are located in the `scripts/` subdirectory.
- This project assumes basic familiarity with HPC systems, SLURM, and module environments.

---

## 🔭 Roadmap

Additional workflows (e.g. RNA-seq processing) will be added over time, each in their own subdirectory under this repository.

---

## Author

Trent Newman
