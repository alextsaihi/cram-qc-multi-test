#!/usr/bin/env nextflow

params.input = []



Channel.fromList(params.input)

// Channel.fromPath(params.input).set{cram}

input = params.input

def helpMessage(message) {
    log.info"""
    ${message}
    Get the header of a SAM/BAM/CRAM file using samtools head and print to stdout
    Usage:
    nextflow run yash-puligundla/samtools-head-nf --input \${INPUT}
    Mandatory arguments:
      --input    [string] local path or URL to input SAM/BAM/CRAM

    Optional arguments:
      --help     [flag] display this help message and exit

    """.stripIndent()
}

if (params.help) exit 0, helpMessage("")

if (input == null) {
    exit 1, helpMessage("ERROR: no --input specified")
}

process samtools_head {

    output:
        path "output_samtools_head.txt"

    script:
    """
    samtools head ${input} > output_samtools_head.txt
    """
}
