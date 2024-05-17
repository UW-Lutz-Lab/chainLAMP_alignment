#!/bin/bash

# Directory containing BAM files
BAM_DIR="/Users/jason/Library/CloudStorage/OneDrive-UW/jason_rupp/nanopore/20240418_chainLAMP/ATJ329/demuxed_reads"

# Reference genome
REFERENCE="/Users/jason/Library/CloudStorage/OneDrive-UW/jason_rupp/nanopore/20240418_chainLAMP/chainLamp_consensus.fasta"

# Loop through each BAM file in the directory
for BAM_FILE in ${BAM_DIR}/*.bam; do
    # Extract the basename without the extension
    BASENAME=$(basename "${BAM_FILE}" .bam)

    # Run Nextflow
    nextflow run /Users/jason/Library/CloudStorage/OneDrive-UW/Documents/research_projects/202311_nanopore/chainLAMP_alignment_pipeline/main.nf \
        --reads "${BAM_FILE}" \
        --reference "${REFERENCE}" \
        --outdir "./processed_results_q20_k7/${BASENAME}/"
done
