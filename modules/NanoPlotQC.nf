def runNanoPlotQC(reads, out_dir, input_type) {
    """
    $workflow.projectDir/pipeline_scripts/NanoPlotQC.sh \
    --reads ${reads} \
    --input_type ${input_type} \
    --out_dir ${out_dir}_qc
    """
}

process NanoPlotQC_Unaligned {
    // tag "NanoStats QC ${reads.baseName}"

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
    // tag "NanoStats QC ${reads.baseName}"

    input:
    path reads
    val input_type

    output:
    path "${reads.baseName}_qc"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    runNanoPlotQC(reads, "${reads.baseName}", input_type) 
}
