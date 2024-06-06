process AlignReads {
    tag "Aligning ${reads.baseName}"

    input:
    path reads
    path ref
    // val quality_level

    output:
    path "${reads.baseName}_aligned.sam"
    // file "${reads.baseName}_aligned.sam"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    """
    $workflow.projectDir/pipeline_scripts/AlignReads.sh \
    --reference ${ref} \
    --reads ${reads} \
    --output ${reads.baseName}_aligned.sam
    """
}
