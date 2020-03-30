#!/bin/bash

set -e

for file in "$@"; do
  tflint $file
done