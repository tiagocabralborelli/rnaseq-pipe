# rnaseq-pipe

## 1. Install conda
```
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
bash Anaconda3-2023.09-0-Linux-x86_64.sh
```

## 2. Install and activate conda env
```
conda env create -f env.yml 
conda activate bio
```

## 3 Install Java V17
```
conda install -c conda-forge openjdk=17 -n bio
```


## 4. Install nextflow
```
curl -s https://get.nextflow.io | bash
chmod +x nextflow
mv nextflow  ~/anaconda3/envs/bio/bin
```

## 5. Create the index from the reference genome 
```
STAR --runThreadN 12 --runMode genomeGenerate --genomeDir indice_star --genomeFastaFiles reference/GCA_001910725.1_ASM191072v1_genomic.fna --sjdbGTFfile reference/augustus.gtf --sjdbOverhang 100 --genomeSAindexNbases 11 --sjdbGTFfeatureExon "CDS" --sjdbGTFtagExonParentTranscript "transcript_id" --sjdbGTFtagExonParentGene "gene_id" 
```

## 6. Run the pipeline
 ```
 nextflow run main.nf --accession 
 ```