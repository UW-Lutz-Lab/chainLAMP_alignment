#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.reads = "$baseDir/data/*.fastq" 
// params.reference = "./chainLamp_consensus.fasta"

// basename = file(params.reads).getName().split("\\.")[0] 
// params.outdir = "${basename}_processed_results/"

// params.outdir = "./processed_results/"

params.quality_filter = 20

include { SortBamUnaligned; SortBamAligned } from "./modules/SortBam.nf"
include { NanoPlotQC_Unaligned; NanoPlotQC_Aligned } from "./modules/NanoPlotQC.nf"
include { BamConvertQualFilter } from "./modules/BamConvertQualFilter.nf"
include { AlignReads } from "./modules/AlignReads.nf"
include { CoverageDepth } from "./modules/CoverageDepth.nf"
include { PlotCoverage } from "./modules/PlotCoverage.nf" 


workflow {

    reads_ch = Channel.fromPath(params.reads)
    ref_ch = Channel.fromPath(params.reference)

    unaligned_sorted_reads = SortBamUnaligned(reads_ch)
    NanoPlotQC_Unaligned(unaligned_sorted_reads, "ubam")
    filtered_fastq = BamConvertQualFilter(reads_ch, params.quality_filter)
    aligned_reads = AlignReads(filtered_fastq, ref_ch)
    aligned_sorted_reads = SortBamAligned(aligned_reads)
    NanoPlotQC_Aligned(aligned_sorted_reads, "bam")
    read_depth = CoverageDepth(aligned_sorted_reads)
    PlotCoverage(read_depth)

}

