def runNanoPlotQC(reads, out_dir, input_type) {
    """
    $workflow.projectDir/pipeline_scripts/NanoPlotQC.sh \
    --reads ${reads} \
    --input_type ${input_type} \
    --out_dir ${out_dir}_qc
    """
}

process NanoPlotQC_Unaligned {
    input:
    path reads
    val input_type

    output:
    path "${reads.baseName}_qc"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    runNanoPlotQC(reads, "${reads.baseName}", input_type) 
}

process NanoPlotQC_Aligned {
    input:
    path reads
    val input_type

    output:
    path "${reads.baseName}_qc"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    runNanoPlotQC(reads, "${reads.baseName}", input_type) 
}
