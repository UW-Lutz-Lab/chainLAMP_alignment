def SortBam(reads, outfile_name) {
    """
    $workflow.projectDir/pipeline_scripts/SortBam.sh \
    --reads ${reads} \
    --outfile_name ${outfile_name}
    """
}

process SortBamUnaligned {
    // tag "Sorting ${reads}"

    input:
    path reads

    output:
    // path "${reads.baseName}_sorted.bam"
    path "${reads.baseName}_unaligned_sorted.bam"

    publishDir "${params.outdir}", mode: 'copy'

    // script:
    // """
    // samtools sort -o ${reads.baseName}_${outfile_name_ext}.bam ${reads}
    // """
    script:
    // """
    // $workflow.projectDir/pipeline_scripts/SortBam.sh \
    // --reads ${reads} \
    // --outfile_ext ${reads.baseName}_unaligned_sorted.bam
    // """
    SortBam("${reads}", "${reads.baseName}_unaligned_sorted.bam")

}

process SortBamAligned {
    // tag "Sorting ${reads}"

    input:
    path reads

    output:
    // path "${reads.baseName}_sorted.bam"
    path "${reads.baseName}_sorted.bam"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    SortBam("${reads}", "${reads.baseName}_sorted.bam")
}
