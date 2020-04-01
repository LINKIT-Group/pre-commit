#!/bin/sh

set -e

for file in "$@"; do
  terragrunt hclfmt --terragrunt-hclfmt-file "$file"
done
