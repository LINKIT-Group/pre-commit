#!/bin/bash

for i in "$@"; do
  case $i in
    --setup-file=*) setupFile="${i#*=}"; echo $setupFile; exit; ;;
  esac
  shift
done

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  terragrunt init -backend=false "$dir"
  # fetch file for validation setup
  [[ -f "$setupFile" ]] && { echo "fetching $setupFile"; cp "$setupFile" "$dir"; }
  terragrunt validate "$dir"
  # validation teardown
  [[ -f "$setupFile" ]] && { rm "$dir/${setupFile##*/}"; }
done
