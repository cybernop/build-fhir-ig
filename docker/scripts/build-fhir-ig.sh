#!/bin/sh

if [ -z "$IGPUB_VERSION" ]; then
    IGPUB_VERSION=1.8.8
fi

if [ -n "${SUSHI_VERSION}" ]; then
    SUSHI=-sushi-${SUSHI_VERSION}
fi

if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR=$PWD/output
fi

if [ ! -d "$OUTPUT_DIR" ] ; then
  mkdir -p $OUTPUT_DIR
fi

if [ -z "$1" ]; then
    PROJECT_DIR=$PWD
else
    PROJECT_DIR=$1
fi

IMAGE=cybernop/build-fhir-ig:$IGPUB_VERSION$SUSHI

PROJECT_MOUNT=${PROJECT_DIR}:/project
FHIR_CACHE_MOUNT=${HOME}/.fhir/packages:/root/.fhir/packages
OUTPUT_MOUNT=${OUTPUT_DIR}:/output

docker run --rm -v $PROJECT_MOUNT -v $FHIR_CACHE_MOUNT -v $OUTPUT_MOUNT --pull always $IMAGE
