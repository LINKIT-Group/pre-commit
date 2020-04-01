#!/bin/bash

while [[ $1 = --* ]]; do
  case $1 in
    --setup-file) setupFile="$2"; shift ;;
  esac
  shift
done

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  terraform init -backend=false "$dir"
  # fetch file for validation setup
  [[ -f "$setupFile" ]] && { echo "fetching $setupFile"; cp "$setupFile" "$dir"; }
  terraform validate "$dir"
  # validation teardown
  [[ -f "$setupFile" ]] && { rm "$dir/${setupFile##*/}"; }
done
