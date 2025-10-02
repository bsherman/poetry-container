# poetry-container
A reusable containerized python poetry

[![build-poetry](https://github.com/bsherman/poetry-container/actions/workflows/build.yml/badge.svg)](https://github.com/bsherman/poetry-container/actions/workflows/build.yml)

A containerized python poetry image

## What is this?

This is a pre-installed [poetry](https://python-poetry.org/) image which runs via docker/podman without need for local python/pip installation.

It can be used to execute poetry locally (in container) to use a `pyproject.toml` to install requirements and run operations on the resulting virtual environment. It can also be used to run webapps or other projects in container without the need to install your own poetry.

Python-slim docker images (based on Debian) are used as this builds libc compatible python shared objects.


The image is based on the [offical python alpine image](https://hub.docker.com/_/python) for minimal size.

The image builds weekly, and automatically builds the latest python 3.11.x and poetry combo.

In addition, there are two variants:
- `poetry:git` (formerly `poetry:latest`) is just poetry plus git
- `poetry:extras` contains git and extra tools for specific use cases

## How do I use it?

If using bash or zsh, one can use an alias:

```bash
alias poetry='if ! [ -d "$HOME/.cache/pypoetry" ]; \
  then \
    mkdir -p "$HOME/.cache/pypoetry"; \
  fi; \
  podman run --rm -it \
    --security-opt label=disable \
    -v "$PWD:/pwd" \
    -v "$HOME/.cache/pypoetry:/root/.cache/pypoetry" \
    --net=host \
    ghcr.io/bsherman/poetry:git "$@"'
```

Of course, you can also put that in a shell script if you prefer by running the following:

```bash
cat << EOF > $HOME/bin/poetry
if ! [ -d "$HOME/.cache/pypoetry" ]; then
  mkdir -p "$HOME/.cache/pypoetry"
fi

podman run --rm -it \\
  --security-opt label=disable \\
  -v "\$PWD:/pwd" \\
  -v "\$HOME/.cache/pypoetry:/root/.cache/pypoetry" \\
  --net=host \\
  ghcr.io/bsherman/poetry:git "\$@"
EOF
chmod +x $HOME/bin/poetry
```

## How do I upgrade?
The alias/script above automatically installs the container image, but wont' update it. To do that, run:

```bash
podman pull ghcr.io/bsherman/poetry:git
```

## Disclaimer

This is not an official release of poetry; I am not affiliated with the [poetry project](https://python-poetry.org/), just a user who wants to use it via container.

There is no warranty, but you can read what little code exists in this repository and see how it builds. Nothing hidden here.

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the appropriate command:

    cosign verify --key cosign.pub ghcr.io/bsherman/poetry:git
