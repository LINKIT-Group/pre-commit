#!/bin/bash

set -e

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  terraform init -backend=false "$dir"
  terraform validate "$dir"
done
