ARG OS_BASE

FROM ghcr.io/cybernop/build-fhir-profiles:base-ubuntu AS base-ubuntu

RUN apt update \
    && apt install -y \
    openjdk-21-jre \
    ruby-full \
    build-essential \
    zlib1g-dev

ENV GEM_HOME=/root/gems
ENV PATH=$GEM_HOME/bin:$PATH

RUN gem install jekyll bundler


FROM ghcr.io/cybernop/build-fhir-ig:base-$OS_BASE AS online

COPY entrypoint-online.sh /root/entrypoint.sh
RUN chmod a+rwx /root \
    && chmod a+x /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh", "/project" ]


FROM ghcr.io/cybernop/build-fhir-ig:base-$OS_BASE AS offline

RUN mkdir /root/input-cache \
    && chmod a+rx /root \
    && curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o "/root/publisher.jar" --create-dirs

COPY entrypoint-offline.sh /root/entrypoint.sh
RUN chmod a+x /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh", "/project" ]
