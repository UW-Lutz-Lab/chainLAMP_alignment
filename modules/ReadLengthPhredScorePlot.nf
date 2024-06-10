PLOT_READS = file("$workflow.projectDir/pipeline_scripts/ReadLengthPhredScorePlot.py")

process ReadLengthPhredScorePlot {
    tag "QC-ing ${reads.baseName}"

    input:
    path reads

    output:
    path "${reads.baseName}_RLvPS_plot.html"
    // file "${reads.baseName}_aligned.sam"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    """
    /opt/miniconda3/envs/pytimez/bin/python ${PLOT_READS}\
    --input_bam ${reads} \
    --output ${reads.baseName}_RLvPS_plot.html
    """
}