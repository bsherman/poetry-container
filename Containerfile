ARG PYTHON_VERSION=${PYTHON_VERSION:-latest}

FROM cgr.dev/chainguard/python:${PYTHON_VERSION}-dev as builder

ARG PYTHON_VERSION=${PYTHON_VERSION:-latest}
ARG POETRY_VERSION=${POETRY_VERSION}

ARG PIP_DEFAULT_TIMEOUT=100
ARG PIP_DISABLE_PIP_VERSION_CHECK=on
ARG PIP_NO_CACHE_DIR=off
ARG PYTHONFAULTHANDLER=1
ARG PYTHONUNBUFFERED=1

USER root

ENV PATH="$PATH:/root/.local/bin"

RUN pip install --user poetry==${POETRY_VERSION} && poetry --version

FROM cgr.dev/chainguard/python:${PYTHON_VERSION}

USER root

WORKDIR /pwd

VOLUME /pwd

VOLUME /root/.cache/pypoetry

ENV PATH="$PATH:/root/.local/bin"

COPY --from=builder /root/.local /root/.local


ENTRYPOINT [ "poetry" ]