configfile: "config.yaml"

ACCESSION = config["accession"]
GENOME_DIR = f"../../{ACCESSION}"  # Output one level above the repo
WRKFLW_DIR = "Genome_download"

rule all:
    input:
        f"{GENOME_DIR}/bowtie2_index_complete.txt",
        f"{GENOME_DIR}/hisat2_index_complete.txt"

rule download_ncbi_cli:
    output:
        f"../{WRKFLW_DIR}/tools/datasets"
    shell:
        "bash scripts/download_ncbi_cli.sh {output}"

rule fetch_genome:
    input:
        cli=f"../{WRKFLW_DIR}/tools/datasets"
    output:
        f"{GENOME_DIR}/ncbi_dataset.zip"
    params:
        acc=ACCESSION
    shell:
        "bash scripts/fetch_genome.sh {input.cli} {params.acc} {output}"

rule unzip_genome:
    input:
        f"{GENOME_DIR}/ncbi_dataset.zip"
    output:
        touch(f"{GENOME_DIR}/extracted.txt")
    params:
        acc=ACCESSION
    shell:
        "bash scripts/unzip_and_arrange.sh {input} {params.acc} {GENOME_DIR} {output}"

rule bowtie2_index:
    input:
        f"{GENOME_DIR}/extracted.txt"
    output:
        f"{GENOME_DIR}/bowtie2_index_complete.txt"
    shell:
        "bash scripts/index_bowtie2.sh {GENOME_DIR} {output}"

rule hisat2_index:
    input:
        f"{GENOME_DIR}/extracted.txt"
    output:
        f"{GENOME_DIR}/hisat2_index_complete.txt"
    shell:
        "bash scripts/index_hisat2.sh {GENOME_DIR} {output}"


