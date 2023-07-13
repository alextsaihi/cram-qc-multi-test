#!/usr/bin/env nextflow

params.input = []

Channel.from(params.input)

// Channel.fromPath(params.input).set{cram}

if (params.input == null) {
    exit 1, helpMessage("ERROR: no --input specified")
}

process run_flagstat {
    label 'samtools'
    input:
    file cram

    output:
       file("${cram}.flagstat") into flagstat_file
    
    script:
    """
    samtools flagstat \
    -@ 1 \
    ${cram} > ${cram}.flagstat
    """
}

process run_multiqc{
    label 'multiqc'

    input:
        file('*') from flagstat_file.collect()

    output:
        file('multiqc_report.html')

    """
    multiqc .
    """
}
