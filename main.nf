#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.reads = "$baseDir/data/*.fastq" 
// params.reference = "./chainLamp_consensus.fasta"

// basename = file(params.reads).getName().split("\\.")[0] 
// params.outdir = "${basename}_processed_results/"

// params.outdir = "./processed_results/"

include { SortBamUnaligned; SortBamAligned } from "./modules/SortBam.nf"
include { NanoPlotQC_Unaligned; NanoPlotQC_Aligned } from "./modules/NanoPlotQC.nf"
include { BamConvertQualFilter } from "./modules/BamConvertQualFilter.nf"
include { AlignReads } from "./modules/AlignReads.nf"
include { CoverageDepth } from "./modules/CoverageDepth.nf"
include { PlotCoverage } from "./modules/PlotCoverage.nf" 


// Read and parse the CSV file
samples = file(params.samplesheet)

def sample_data = []
samples.withReader { reader ->
    reader.readLine() // Skip the header
    reader.eachLine { line ->
        def fields = line.split(',')
        def alias = fields[0]
        def filepath = "${params.base_dir}/${fields[1]}"
        def ref_filepath = "${params.base_dir}/${fields[2]}"
        sample_data << [ alias: alias, filepath: filepath, reference: ref_filepath ]
    }
}

process CreateOutdir {
    input:
    val read

    script:
    """
    mkdir -p \"/processed_results/${read.alias}\"
    """
}

workflow {

    Channel
        .from( sample_data )
        .set { bam_channel }

    ref_ch = Channel.fromPath(params.reference)


    CreateOutdir(bam_channel)

    unaligned_sorted_reads = SortBamUnaligned(bam_channel)

    NanoPlotQC_Unaligned(
        unaligned_sorted_reads[0], 
        "ubam", 
        unaligned_sorted_reads[1])
    
    filtered_fastq = BamConvertQualFilter(
        unaligned_sorted_reads[0],
        params.quality_filter,
        params.minlength,
        params.maxlength,
        unaligned_sorted_reads[1],
        unaligned_sorted_reads[2])

    aligned_reads = AlignReads(
        filtered_fastq[0], 
        filtered_fastq[2], 
        params.k, 
        params.w, 
        filtered_fastq[1])
    // aligned_sorted_reads = SortBamAligned(aligned_reads)
    aligned_sorted_reads = SortBamAligned(aligned_reads[0], aligned_reads[1])
    '''
    NanoPlotQC_Aligned(aligned_sorted_reads[0], "bam", aligned_sorted_reads[1])
    read_depth = CoverageDepth(aligned_sorted_reads[0], aligned_sorted_reads[1])
    PlotCoverage(read_depth, aligned_sorted_reads[1])
    '''
}

