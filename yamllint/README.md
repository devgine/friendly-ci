# Yaml lint

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
    branches:
      - main
    paths:
      - '**.yaml'
      - '**.yml'
      - .yamllint
jobs:
  job-id:
    runs-on: ubuntu-latest
    name: "Yaml lint"
    container:
      image: ghcr.io/devgine/yamllint:latest
    steps:
      - name: 'Run'
        run: . -s -c .yamllint
```

### Gitlab-ci
```yaml
stages:
 - lint

lint-yaml:
  stage: lint
  image:
    name: ghcr.io/devgine/yamllint:latest
    entrypoint: [""]
  script:
    - yamllint . -s -f colored
```

## Scan
```shell
docker run --rm -v $PWD:/srv checkmarx/kics:v2.1.3-alpine \
  scan --no-progress -p /srv --exclude-gitignore --exclude-queries='d3499f6d-1651-41bb-a9a7-de925fea487b'
```

## References
https://yamllint.readthedocs.io/en/stable/index.html
