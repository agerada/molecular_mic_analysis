#!/bin/bash

# Define the values for the -a parameter
ANTIBIOTICS=("GEN" "CIP")

# Loop through each antibiotic value
for a in "${ANTIBIOTICS[@]}"; do
    echo "Running tune.R for $a..."
    Rscript scripts/tune.R \
        -k 3 \
        -o "output/3/" \
        -a "$a" \
        -r 100 \
        -e 0.02 \
        -f 5 \
        data/annots/ \
        data/meta_data_bv_brc_format.txt \
        data/kmers/

    echo "Running train.R for $a..."
    Rscript scripts/train.R \
        -k 3 \
        -o "output/3/" \
        -a "$a" \
        -r 6000 \
        -e 0.005 \
        -f 5 \
        --early_stop 10 \
        --pre_fold_info "output/3/${a}_folds_tune_genome_names.rds" \
        data/annots/ \
        data/meta_data_bv_brc_format.txt \
        data/kmers/
done
