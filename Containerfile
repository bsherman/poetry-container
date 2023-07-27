ARG PYTHON_VERSION=${PYTHON_VERSION:-latest}

FROM docker.io/library/python:${PYTHON_VERSION}-slim

ARG PYTHON_VERSION=${PYTHON_VERSION:-latest}
ARG POETRY_VERSION=${POETRY_VERSION}

ARG PIP_DEFAULT_TIMEOUT=100
ARG PIP_DISABLE_PIP_VERSION_CHECK=on
ARG PIP_NO_CACHE_DIR=off
ARG PYTHONFAULTHANDLER=1
ARG PYTHONUNBUFFERED=1

VOLUME /app

VOLUME /root/.cache/pypoetry

WORKDIR /app

ENV PATH="$PATH:/root/.local/bin"

RUN pip install --user poetry==${POETRY_VERSION} && poetry --version

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean all

ENTRYPOINT [ "poetry" ]
