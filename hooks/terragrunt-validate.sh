#!/bin/bash

# Run terragrunt validate for all on directories which include env.hcl
for dir in $(echo "$@" | grep env.hcl | xargs -n1 dirname | sort -u | uniq); do
  terragrunt validate-all
done
