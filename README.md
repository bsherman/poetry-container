# poetry-container
A reusable containerized python poetry

[![build-poetry](https://github.com/bsherman/poetry-container/actions/workflows/build.yml/badge.svg)](https://github.com/bsherman/poetry-container/actions/workflows/build.yml)

A containerized python poetry image

## What is this?

This is a pre-installed [poetry](https://python-poetry.org/) image which runs via docker/podman without need for local python/pip installation.

The image is based on [chainguard's python image](https://edu.chainguard.dev/chainguard/chainguard-images/reference/python/overview/) for security and minimal size.

The image builds daily, and automatically builds the latest python and poetry combo. (Note: I'm not sure how quickly Chainguard deploys new version images after new python releases, so there could be a few days after one where this doesn't build.)

## How do I use it?

If using bash or zsh, I'd suggest an alias:

```bash
alias poetry='if ! [ -d "$HOME/.cache/pypoetry" ]; \
  then \
    mkdir -p "$HOME/.cache/pypoetry"; \
  fi; \
  podman run --rm -it \
    --security-opt label=disable \
    -v "$PWD:/pwd" \
    -v "$HOME/.cache/pypoetry:/root/.cache/pypoetry" \
    ghcr.io/bsherman/poetry:latest "$@"'
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
  ghcr.io/bsherman/poetry:latest "\$@"
EOF
chmod +x $HOME/bin/poetry
```

## How do I upgrade?
The alias/script above automatically installs the container image, but wont' update it. To do that, run:

```bash
podman pull ghcr.io/bsherman/poetry:latest
```

## Disclaimer

This is not an official release of poetry; I am not affiliated with the [poetry project](https://python-poetry.org/), just a user who wants to use it via container.

There is no warranty, but you can read what little code exists in this repository and see how it builds. Nothing hidden here.