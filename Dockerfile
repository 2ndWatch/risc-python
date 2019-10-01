FROM python:3.7-slim-buster

WORKDIR /app

ARG SYSTEM_PACKAGES="make"

RUN apt-get -qq update
RUN apt-get -qq install apt-utils
RUN apt-get -qq upgrade
RUN apt-get -qq install ${SYSTEM_PACKAGES}

COPY . /app

RUN pip install --upgrade pip
RUN pip install --upgrade wheel setuptools twine pipenv
RUN pipenv install --dev --system --deploy

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ARG BUILD_DATETIME
ARG SHA1
ARG VERSION

LABEL io.github.2ndWatch.description="RISC CLI and API client module" \
    io.github.2ndWatch.documentation="https://2ndWatch.github.io/risc-python/" \
    io.github.2ndWatch.licenses="MIT" \
    io.github.2ndWatch.image.revision=$SHA1 \
    io.github.2ndWatch.image.version=$VERSION \
    io.github.2ndWatch.image.vendor="2ndWatch" \
    io.github.2ndWatch.image.source="https://github.com/2ndWatch/risc-python" \
    io.github.2ndWatch.image.title="RISC Client" \
    io.github.2ndWatch.image.created=$BUILD_DATETIME