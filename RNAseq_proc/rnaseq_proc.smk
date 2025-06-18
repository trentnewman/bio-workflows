configfile: "config.yaml"

ACCESSION = config["accession"]
RNASEQ_DIR = f"../../{ACCESSION}"  # Output one level above the repo
REF_ACC = config["genome_accession"]
REF_DIR = f"../../{REF_ACC}" 
REF_NM = config["genome_name"]
WRKFLW_DIR = "RNAseq_proc"

rule all:
    input:
        #f"{RNASEQ_DIR}/{ACCESSION}"
        #f"{RNASEQ_DIR}/{ACCESSION}_1.fastq",
        #f"{RNASEQ_DIR}/{ACCESSION}_2.fastq"
        #f"{RNASEQ_DIR}/{ACCESSION}_1_val_1.fq",
        #f"{RNASEQ_DIR}/{ACCESSION}_2_val_2.fq"
        f"{RNASEQ_DIR}/{ACCESSION}.bam",
        f"{RNASEQ_DIR}/{ACCESSION}.bam.csi",
        f"{RNASEQ_DIR}/{ACCESSION}.bw"

rule download_sra:
    output:
        f"{RNASEQ_DIR}/{ACCESSION}"
    shell:
        "bash scripts/wget.sh {output}"

rule dump_fastq:
    input:
        sra = f"{RNASEQ_DIR}/{ACCESSION}"
    output:
        r1 = f"{RNASEQ_DIR}/{ACCESSION}_1.fastq",
        r2 = f"{RNASEQ_DIR}/{ACCESSION}_2.fastq"
    shell:
        "bash scripts/sra_dump.sh {input.sra}"

rule trim_reads:
    input:
        r1 = f"{RNASEQ_DIR}/{ACCESSION}_1.fastq",
        r2 = f"{RNASEQ_DIR}/{ACCESSION}_2.fastq"
    output:
        r1_trimmed = f"{RNASEQ_DIR}/{ACCESSION}_1_val_1.fq",
        r2_trimmed = f"{RNASEQ_DIR}/{ACCESSION}_2_val_2.fq"
    shell:
        "bash scripts/trim.sh {input.r1} {input.r2}"

rule map_reads:
    input:
        read1 = f"{RNASEQ_DIR}/{ACCESSION}_1_val_1.fq",
        read2 = f"{RNASEQ_DIR}/{ACCESSION}_2_val_2.fq",
        index = f"{REF_DIR}/{REF_NM}.1.ht2" # check any single .ht2 file
    output:
        bam = f"{RNASEQ_DIR}/{ACCESSION}.bam",
        csi = f"{RNASEQ_DIR}/{ACCESSION}.bam.csi",
        bw = f"{RNASEQ_DIR}/{ACCESSION}.bw"
    params:
        index_prefix = f"{REF_DIR}/{REF_NM}"
    shell:
        "bash scripts/map.sh {input.read1} {input.read2} {params.index_prefix} {output.bam}"


