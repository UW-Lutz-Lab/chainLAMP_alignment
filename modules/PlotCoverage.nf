
PLOT_COVERAGE = file("$workflow.projectDir/pipeline_scripts/coverage_plot.py")
TARGET_REGION_CSV = file("$workflow.projectDir/pipeline_scripts/target_region_map_updated.csv")"

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
        python ${PLOT_COVERAGE}\
        --coverage_csv ${coverage_csv} \
        --plot_name ${coverage_csv.baseName.split('_f')[0]}_coverage_plot.html \
        --target_region_csv ${TARGET_REGION_CSV}
        """
}