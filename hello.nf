#!/usr/bin/env nextflow

process sayHello {
    publishDir "results", mode: 'copy'
    
    input:
    val greeting

    output:
    path "$greeting-hello.txt"

    script:
    """
    echo "$greeting" > "$greeting-hello.txt"
    """
} 

params.greeting = "greetings.csv"

workflow {
    greeting_ch = Channel.fromPath(params.greeting)
                        .view(csv -> "Before: $csv")
                        .splitCsv()
                        .map{item -> item[0]}   
                        .view(csv -> "After: $csv")
                    
    sayHello(greeting_ch)
}