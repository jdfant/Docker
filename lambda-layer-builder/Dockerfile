FROM python:3.12

LABEL name="lambda-layer-builder" \
      lambda-layer-builder-version="0.2" \
      description="JD's Lambda Layer Builder" \
      maintainer="jd@jdfant.com" \
      build-date="2024-09-07"

ENV BUILD_DIR=/Lambda_Layer

USER 0

WORKDIR $BUILD_DIR
COPY --chmod=755 entrypoint.sh /
COPY requirements.txt $BUILD_DIR

WORKDIR /

RUN apt-get -qq update --no-install-recommends && \
    apt-get -qq install --no-install-recommends --no-install-suggests \
    zip && \
    apt-get -qq autoremove && apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/entrypoint.sh" ]
