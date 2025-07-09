mkdir -p data

wget https://datacat.liverpool.ac.uk/3008/7/genomes.zip --no-check-certificate
unzip -o genomes.zip -d data/genomes
rm genomes.zip
rm -rf data/__MACOSX

wget https://datacat.liverpool.ac.uk/3008/3/annots.zip --no-check-certificate
unzip -o annots.zip -d data/annots
rm annots.zip
rm -rf data/__MACOSX

wget https://datacat.liverpool.ac.uk/3008/2/meta_data_tidy.txt --no-check-certificate
mv meta_data_tidy.txt data/meta_data_tidy.txt

wget https://datacat.liverpool.ac.uk/3008/4/meta_data_bv_brc_format.txt --no-check-certificate
mv meta_data_bv_brc_format.txt data/meta_data_bv_brc_format.txt
