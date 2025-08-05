# Example make mers

Rscript scripts/make_kmers.R \
  -k 3 \
  -o data/kmers \
  -a "CAZ,CIP,FEP,GEN,MEM" \
  -q \
  data/meta_data_bv_brc_format.txt \
  data/genomes
