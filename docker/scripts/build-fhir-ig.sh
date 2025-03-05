#!/bin/sh

if [ -z "$IGPUB_VERSION" ]; then
    IGPUB_VERSION=1.8.8
fi

if [ -n "${SUSHI_VERSION}" ]; then
    SUSHI=-sushi-${SUSHI_VERSION}
fi

if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR=$PWD/output

    if [ ! -d "$OUTPUT_DIR" ] ; then
    mkdir -p $OUTPUT_DIR
    fi
fi

if [ -z "$1" ]; then
    PROJECT_DIR=$PWD
else
    PROJECT_DIR=$1
fi

if [ -z "$PUBLISH_URL" ]; then
    PUBLISH="PUBLISH_URL="
else
    PUBLISH="PUBLISH_URL=$PUBLISH_URL"
fi

if [ -z "$JAVA_OPTS" ]; then
    JAVA_OPTIONS="_JAVA_OPTIONS=-Xmx2g"
else
    JAVA_OPTIONS="_JAVA_OPTIONS=$JAVA_OPTS"
fi

IMAGE=cybernop/build-fhir-ig:$IGPUB_VERSION$SUSHI

PROJECT_MOUNT=${PROJECT_DIR}:/project
FHIR_CACHE_MOUNT=${HOME}/.fhir/packages:/root/.fhir/packages
OUTPUT_MOUNT=${OUTPUT_DIR}:/output

docker run --rm -v $PROJECT_MOUNT -v $FHIR_CACHE_MOUNT -v $OUTPUT_MOUNT -e $PUBLISH -e $JAVA_OPTIONS --pull always $IMAGE
