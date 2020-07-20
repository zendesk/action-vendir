# action-vendir

A GitHub action for executing vendir. Typical usage will be to 
* vendor copies of a third party repo's files and create a PR to the local repo
or
* vendor copies of a third party repo's files to use within another action

## Inputs

* `token` - specifies the GitHub OAuth token to use when cloning. REQUIRED
* `locked` - when set to `true`, `vendir` will be executed with the `--locked`
option. OPTIONAL, defaults to `false`
* `vendir_file` - specifies the YAML file that `vendir` should evaluate. 
OPTIONAL, defaults to `vendir.yml`


## Output

This Action has no outputs.

## Usage

### Print to STDOUT

```yaml
steps:
  - id: action-vendir
    uses: zendesk/action-vendir@v1
    with:
      token: ${{ secrets.github_token }}
```

### Use vendir lock file

```yaml
steps:
  - id: action-vendir
    uses: zendesk/action-vendir@v1
    with:
      token: ${{ secrets.github_token }}
      locked: true
```

### Use a file other than `vendir.yml`

```yaml
steps:
  - id: action-vendir
    uses: zendesk/action-vendir@v1
    with:
      token: ${{ secrets.github_token }}
      vendir_file: some_other_file.yml
```