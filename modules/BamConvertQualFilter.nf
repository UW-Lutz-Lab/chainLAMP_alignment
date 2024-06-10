process BamConvertQualFilter {
    tag "Converting ${reads.baseName} to Fastq"

    input:
    path reads
    val quality_level

    output:
    path "${reads.baseName}_f${quality_level}.fastq"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    """
    mkdir -p ${params.outdir}
    $workflow.projectDir/pipeline_scripts/BamConvertQualFilter.sh \
    --quality_filter ${quality_level} \
    --reads ${reads} \
    --output ${reads.baseName}_f${quality_level}.fastq
    """
}