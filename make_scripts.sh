#!/bin/bash

# Ensure the output directory exists
mkdir -p scripts

# Iterate through all .Rmd files in notebooks/
for rmd_file in notebooks/*.Rmd; do
  # Get the base filename (without extension)
  base_name=$(basename "$rmd_file" .Rmd)

  # Set output path
  output_path="scripts/${base_name}.R"

  # Call Rscript with knitr::purl()
  Rscript -e "knitr::purl('$rmd_file', output = '$output_path')"
done
