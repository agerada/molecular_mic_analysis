#!/bin/bash -l
#SBATCH -D ./
#SBATCH --export=ALL
#SBATCH -J 10k_5f
#SBATCH -o 10k_5f_%A_%a.out
#SBATCH --error=10k_5f_%A_%a.err
#SBATCH -p lowpriority,nodes # Use the CPU partition
#SBATCH -N 1                  # Number of nodes
#SBATCH --cpus-per-task=40
#SBATCH --ntasks-per-node=1   # Number of tasks per node
#SBATCH --time=10:00:00       # Increase time limit
#SBATCH --array=0-9

# NOTE: Ensure that make_kmers.R has been run before this script, and
# kmers stored in ~/data/molecular_mic_analysis/kmers/
# This example is provided for demonstration purposes, slurm settings
# parameters will need to be adapted for local configurations.
# Author: Alessandro Gerada, University of Liverpool, UK
# Contact: agerada@liverpool.ac.uk
args=("AMC" "AMK" "AMX" "CAZ" "CHL" "CIP" "FEP" "GEN" "MEM" "TGC")

module load apps/R/4.4.1/gcc-13.2.0+openblas-0.3.28

arg=${args[$SLURM_ARRAY_TASK_ID]}

start=`date +%s`

Rscript ~/molecular_mic_analysis/scripts/tune.R \
  -k 10 -o \
  ~/data/molecular_mic_analysis/output/10/ \
  -a "$arg" \
  -r 100 \
  -e 0.02 \
  -f 5 \
  ~/data/molecular_mic_analysis/annots/  \
  ~/data/molecular_mic_analysis/meta_data_bv_brc_format.txt \
  ~/data/molecular_mic_analysis/kmers/

Rscript ~/molecular_mic_analysis/scripts/train.R \
  -k 10 \
  -o ~/data/molecular_mic_analysis/output/10/ \
  -a "$arg" \
  -f 5 \
  -r 6000 \
  -e 0.005 \
  --early_stop 10 \
  ~/data/molecular_mic_analysis/annots/ \
  ~/data/molecular_mic_analysis/db/meta_data_bv_brc_format.txt \
  ~/data/molecular_mic_analysis/kmers/

end=`date +%s`

runtime=$((end-start))
hours=$((runtime / 3600));
minutes=$(( (runtime % 3600) / 60 ));
seconds=$(( (runtime % 3600) % 60 ));
echo "Runtime: $hours:$minutes:$seconds (hh:mm:ss)"

echo "Finished running - goodbye from $HOSTNAME"
