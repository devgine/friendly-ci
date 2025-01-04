FROM alpine:3.21

RUN apk -u --no-cache add doas yamllint

ARG USERNAME=yamllint

RUN addgroup -S $USERNAME && adduser -D -S $USERNAME -G $USERNAME && \
    echo "permit nopass keepenv $USERNAME as root" > /etc/doas.d/doas.conf && \
    mkdir -p /test && \
    chown -R $USERNAME:$USERNAME /test &&  \
    echo "---" >> /test/test.yaml &&  \
    echo "key: value" >> /test/test.yaml

HEALTHCHECK --interval=5m --timeout=3s --retries=3 CMD yamllint /test/test.yaml || exit 1

WORKDIR /$USERNAME
USER $USERNAME

ENTRYPOINT ["yamllint"]

## LABELS
ARG VCS_REF
ARG BUILD_VERSION
ARG BUILD_DATE
ARG IMAGE_TAG=ghcr.io/devgine/yamllint:latest

LABEL maintainer="yosribahri@gmail.com"
LABEL org.opencontainers.image.title="Yaml lint docker image"
LABEL org.opencontainers.image.description="A docker image that validate yaml files."
LABEL org.opencontainers.image.source="https://github.com/devgine/yamllint"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.url="https://github.com/devgine/yamllint"
LABEL org.opencontainers.image.version=$BUILD_VERSION
LABEL org.opencontainers.image.revision=$VCS_REF
LABEL org.opencontainers.image.vendor="devgine"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="devgine/yamllint"
LABEL org.label-schema.description="A docker image that validate yaml files."
LABEL org.label-schema.url="https://github.com/devgine/yamllint"
LABEL org.label-schema.vcs-url="https://github.com/devgine/yamllint"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --rm -v local-dir:/srv $IMAGE_TAG /srv -s -f colored"
LABEL org.label-schema.vendor="devgine"
