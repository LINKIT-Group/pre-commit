# Pre-commit hooks

This repo defines Git pre-commit hooks intended for use with [pre-commit](http://pre-commit.com/). The currently
supported hooks are:

* **terraform-fmt**: Automatically run `terraform fmt` on all Terraform code (`*.tf` files).
* **terraform-validate**: Automatically run `terraform validate` on all Terraform code (`*.tf` files).
* **tflint**: Automatically run [`tflint`](https://github.com/terraform-linters/tflint) on all Terraform code (`*.tf` files).
* **terragrunt-fmt**: Automatically format all Terragrunt code (`*.hcl` files).

Inspired by the corresponding [gruntwork.io](https://github.com/gruntwork-io/pre-commit) repository! For now it is tailored for the needs of the MLOps platform project,
feel free to extend for general use!

## General Usage

In each of your repos, add a file called `.pre-commit-config.yaml` with the following contents:

```yaml
repos:
  - repo: https://bitbucket.org/linkit-group/pre-commit
    rev: <VERSION> # fill in the latest tag or master for bleeding edge
    hooks:
      - id: terraform-fmt
      - id: terraform-validate
      - id: tflint
      - id: terragrunt-hclfmt
```

Next, have every developer:

1. Install [pre-commit](http://pre-commit.com/). E.g. `brew install pre-commit`.
1. Run `pre-commit install` in the repo.

That’s it! Now every time you commit a code change, the hooks in the `hooks:` config will execute.

## Running Against All Files At Once

### Example: Formatting all files

If you'd like to format all of your code at once (rather than one file at a time), you can run:

```bash
pre-commit run terraform-fmt --all-files
```

### Example: Enforcing in CI

If you'd like to enforce all your hooks, you can configure your CI build to fail if the code doesn't pass checks by
adding the following to your build scripts:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

If all the hooks pass, the last command will exit with an exit code of 0. If any of the hooks make changes (e.g.,
because files are not formatted), the last command will exit with a code of 1, causing the build to fail.

## Advanced usage

### terraform-validate

You can optionally use code for setup/teardown of the validation, if required (e.g., if missing code is added at a later stage in the pipeline). Use the parameter
```--setup-file <path>```, that points to a single file containing the setup/teardown code. This file will be added before validation and removed afterwards.

Example:

```yaml
repos:
  - repo: https://bitbucket.org/linkit-group/pre-commit
    rev: <VERSION> # fill in the latest tag or master for bleeding edge
    hooks:
      - id: terraform-fmt
        args: [--setup-file=test.tf]
```
