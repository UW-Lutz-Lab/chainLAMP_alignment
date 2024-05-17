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

    // script:
    // """
    // mkdir -p ${reads.baseName}_raw_qc
    // /opt/miniconda3/envs/nanoqc/bin/nanoplot --only-report -o ${reads.baseName}_raw_qc --${input_type} ${reads} 
    // """
    script:
    // """
    // $workflow.projectDir/pipeline_scripts/NanoPlotQC.sh \
    // --reads ${reads} \
    // --input_type ${input_type} \
    // --out_dir ${reads.baseName}_raw_qc
    // """
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

    // script:
    // """
    // mkdir -p ${reads.baseName}_raw_qc
    // /opt/miniconda3/envs/nanoqc/bin/nanoplot --only-report -o ${reads.baseName}_raw_qc --${input_type} ${reads} 
    // """
    script:
    // """
    // $workflow.projectDir/pipeline_scripts/NanoPlotQC.sh \
    // --reads ${reads} \
    // --input_type ${input_type} \
    // --out_dir ${reads.baseName}_raw_qc
    // """
    runNanoPlotQC(reads, "${reads.baseName}", input_type) 
}
