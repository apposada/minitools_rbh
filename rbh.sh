#!/bin/bash
blastp -db $1 -query $2 \
                -max_target_seqs 1 -evalue 10E-5 -num_threads 24 -outfmt "6 qseqid sseqid qcovhsp evalue" | \
                tee rbh_1_2_orig.tsv | \
                cut -f1,2 > rbh_1_2.tsv && \
                blastp -db $2 -query $1 \
                -max_target_seqs 1 -evalue 10E-5 -num_threads 24 -outfmt "6 sseqid qseqid qcovhsp evalue" | \
                tee rbh_2_1_orig.tsv | \
                cut -f1,2 > rbh_2_1.tsv && \
                python3 common_lines.py rbh_2_1.tsv rbh_1_2.tsv final_RBH.tsv
