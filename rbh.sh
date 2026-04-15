#!/bin/bash

# variables
fa1=$1
fa2=$2
# retrieve path for outputs
outpath=$(dirname $fa1)
# retrieve base name without file extensions for sp1
basename1=$(basename $fa1)
sp1=${basename1//.*}
# retrieve base name without file extensions for sp2
basename2=$(basename $fa2)
sp2=${basename2//.*}   
# define output file name prefix
outfn="${outpath}/${sp1}__v__${sp2}"

set -e
set --

# blastp and common_lines.py
blastp -db $fa1 -query $fa2 \
                -max_target_seqs 1 -evalue 10E-5 -num_threads 12 -outfmt "6 qseqid sseqid qcovhsp evalue" | \
                tee ${outfn}_rbh_1_2_orig.tsv | \
                cut -f1,2 > ${outfn}_rbh_1_2.tsv && \
                blastp -db $fa2 -query $fa1 \
                -max_target_seqs 1 -evalue 10E-5 -num_threads 12 -outfmt "6 sseqid qseqid qcovhsp evalue" | \
                tee ${outfn}_rbh_2_1_orig.tsv | \
                cut -f1,2 > ${outfn}_rbh_2_1.tsv && \
                common_lines.py ${outfn}_rbh_2_1.tsv ${outfn}_rbh_1_2.tsv ${outfn}_final_RBH.tsv
