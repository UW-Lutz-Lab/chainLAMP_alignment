def SortBam(reads, outfile_name) {
    """
    $workflow.projectDir/pipeline_scripts/SortBam.sh \
    --reads ${reads} \
    --outfile_name ${outfile_name}
    """
}

process SortBamUnaligned {
    input:
    path reads

    output:
    path "${reads.baseName}_unaligned_sorted.bam"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    SortBam("${reads}", "${reads.baseName}_unaligned_sorted.bam")

}

process SortBamAligned {
    input:
    path reads

    output:
    path "${reads.baseName}_sorted.bam"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    SortBam("${reads}", "${reads.baseName}_sorted.bam")
}
