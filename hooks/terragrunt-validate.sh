#!/bin/bash

# Run terragrunt validate only on directories which include terragrunt.hcl
for dir in $(echo "$@" | grep terragrunt.hcl | xargs -n1 dirname | sort -u | uniq); do
  terragrunt validate
done
