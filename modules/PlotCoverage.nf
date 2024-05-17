
PLOT_COVERAGE = file("$workflow.projectDir/pipeline_scripts/coverage_plot.py")


// process PlotCoverage {
//     // tag "Plotting ${reads}"

//     input:
//     file coverage_csv
//     val plot_name
        

//     output:
//     // path "${reads.baseName}_sorted.bam"
//     path "${plot_name}"

//     publishDir "${params.outdir}", mode: 'copy'



    
//     // script:
//     // """
//     // /opt/miniconda3/envs/nanoqc/bin/python ${PLOT_COVERAGE}\
//     // --coverage_csv ${coverage_csv} \
//     // --output ${plotName}_RLvPS_plot.html
//     // """

//     script:
//         // def plotName = "${coverage_csv}".toString().split('_f')[0] + "_coverage_plot"    
//     """
//     /opt/miniconda3/envs/nanoqc/bin/python ${PLOT_COVERAGE}\
//     --coverage_csv ${coverage_csv} \
//     --plot_name ${plotName}
//     """

// }

process PlotCoverage {
    input:
        file coverage_csv

    output:
        // path "${plotName}_RLvPS_plot.html"
        path "${coverage_csv.baseName.split('_f')[0]}_coverage_plot.html"
        
        publishDir "${params.outdir}", mode: 'copy'

    script:
        def baseName = coverage_csv.getBaseName() // Retrieves the filename without extension
        def plotName = baseName.split("-24_")[1].split("_f")[0] + "_coverage_plot"
        """
        /opt/miniconda3/envs/nanoqc/bin/python ${PLOT_COVERAGE}\
        --coverage_csv ${coverage_csv} \
        --plot_name ${coverage_csv.baseName.split('_f')[0]}_coverage_plot.html
        """
}