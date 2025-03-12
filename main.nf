// Define os canais fora do processo
params.outdir = "data"

process Download {
    publishDir params.outdir, mode: 'copy'
    
    // input:  
    // val number
    
    output:
    path "SRR2047523"

    script:
    """
    prefetch SRR2047523
    """
}


workflow {
    Download()
}