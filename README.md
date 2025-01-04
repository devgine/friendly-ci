# Yaml lint

> Repository under construction

## About
A docker image linter for YAML files.<br>
yamllint check for syntax validity, for weirdnesses like key repetition and cosmetic problems such as lines length, trailing spaces, indentation, etc.

## Run
```shell
docker run --rm -v $PWD:/srv ghcr.io/devgine/yamllint:latest /srv -s -f colored
```

## CI
### GitHub action
```yaml
---
name: "Yaml Lint"

on:
  push:
    paths:
      - '**.yaml'
      - '**.yml'
      - .yamllint

permissions:
  contents: 'read'
  id-token: 'write'

jobs:
  yamllint:
    runs-on: ubuntu-latest
    name: "Yaml lint"
    container:
      image: ghcr.io/devgine/yamllint:1.0.0

    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: 'Run'
        run: yamllint . -s -c .yamllint

```

### Gitlab-ci
```yaml
stages:
 - quality

yaml-lint:
  stage: quality
  image:
    name: ghcr.io/devgine/yamllint:1.0.0
    entrypoint: [""]
  script:
    - yamllint . -s -c .yamllint
```

## Scan
```shell
docker run --rm -v $PWD:/srv checkmarx/kics:v2.1.3-alpine \
  scan --no-progress -p /srv --exclude-gitignore --exclude-queries='d3499f6d-1651-41bb-a9a7-de925fea487b'
```

## References
https://yamllint.readthedocs.io/en/stable/index.html
