#!/bin/bash

# terragrunt validate-all will figure out the directories with terragrunt.hcl by itself, so we don't need to handle that.
cd infra && terragrunt validate-all