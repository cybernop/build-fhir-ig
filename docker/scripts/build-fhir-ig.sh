#!/bin/sh

echo "Building with the following configuration:"
if [ -z "$IGPUB_VERSION" ]; then
    IGPUB_VERSION=1.8.8
fi
echo "IG Publisher: $IGPUB_VERSION"

if [ ! -z "${SUSHI_VERSION}" ]; then
    SUSHI=-sushi-${SUSHI_VERSION}
    echo "FSH Sushi: $SUSHI_VERSION"
else
    SUSHI=
fi

if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR=$PWD/output

    if [ ! -d "$OUTPUT_DIR" ] ; then
    mkdir -p $OUTPUT_DIR
    fi
fi
echo "output dir: $OUTPUT_DIR"

if [ -z "$1" ]; then
    PROJECT_DIR=$PWD
else
    PROJECT_DIR=$1
fi
echo "project dir: $PROJECT_DIR"

if [ -z "$PUBLISH_URL" ]; then
    PUBLISH="PUBLISH_URL="
else
    PUBLISH="PUBLISH_URL=$PUBLISH_URL"
    echo "publish url: $PUBLISH_URL"
fi

if [ -z "$JAVA_OPTS" ]; then
    JAVA_OPTS="-Xmx2g"
fi

JAVA_OPTIONS="_JAVA_OPTIONS=$JAVA_OPTS"
printf "Java options: $JAVA_OPTS\n\n\n"

IMAGE=cybernop/build-fhir-ig:$IGPUB_VERSION$SUSHI

PROJECT_MOUNT=${PROJECT_DIR}:/project
FHIR_CACHE_MOUNT=${HOME}/.fhir/packages:/root/.fhir/packages
OUTPUT_MOUNT=${OUTPUT_DIR}:/output

docker run --rm -v $PROJECT_MOUNT -v $FHIR_CACHE_MOUNT -v $OUTPUT_MOUNT -e $PUBLISH -e $JAVA_OPTIONS --pull always $IMAGE
