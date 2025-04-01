
process Download {

    input:  
    val accession
    
    output:
    path "${accession}"

    script:
    """
    prefetch "${accession}"
    """
}

process Dump {

    input:
    path run_file

    output:
    path "${run_file}.fastq"

    script:
    """
    fasterq-dump ${run_file}
    """
}

process Trim {
    
    input:
    path fastq_file

    output:
    path "${fastq_file}_trimmed.fastq"

    script:
    """
    trimmomatic SE ${fastq_file} ${fastq_file}_trimmed.fastq LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    """
}

process Star {


    input:
    path fastq_file
    path index_star

    output:
    path "${fastq_file}_Aligned.sortedByCoord.out.bam" 

    script:
    """
    STAR --runThreadN 12 --genomeDir ${index_star} --readFilesIn ${fastq_file} --outFileNamePrefix ${fastq_file}_ --outSAMtype BAM SortedByCoordinate --quantMode TranscriptomeSAM --outSAMattributes Standard
    """
}

process FeatureCounts {
    publishDir params.outdir, mode: 'copy'

    input:
    path bam_file
    path reference

    output:
    path "${bam_file}_counts.txt"

    script:
    """
    featureCounts -T 12 -t CDS -g gene_id -a ${reference} -o ${bam_file}_counts.txt ${bam_file}
    """
}

// params.accession = "runs.csv"
params.index = "indice_star"
params.reference = "reference/augustus.gtf"

params.outdir = "Data"

workflow {

    // runs_ch = Channel.fromPath(params.accession)
    //                     .view(csv -> "Before: $csv")
    //                     .splitCsv()
    //                     .map{item -> item[0]}
    //                     .view(csv -> "After: $csv")

    index_ch = Channel.fromPath(params.index)
    reference_ch = Channel.fromPath(params.reference)

    Download(params.accession)
    Dump(Download.out)
    Trim(Dump.out)
    Star(Trim.out,index_ch)
    FeatureCounts(Star.out,reference_ch)
}