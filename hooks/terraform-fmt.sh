#!/bin/bash

set -e

for file in "$@"; do
  terraform fmt -write=true "$file"
done
