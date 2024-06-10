process CoverageDepth {
    tag "Getting Read Depth ${reads}"

    input:
    path reads

    output:
    path "${reads.baseName}_coverage_report.csv"

    publishDir "${params.outdir}", mode: 'copy'

    script:
    """
    samtools depth -a ${reads} | awk '{OFS=","; print \$1, \$2, \$3}' > ${reads.baseName}_coverage_report.csv
    """
}