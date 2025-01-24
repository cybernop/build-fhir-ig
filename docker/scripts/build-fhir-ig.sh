#!/bin/sh

if [ -z "$IGPUB_VERSION" ]; then
    IGPUB_VERSION="1.8.8"
fi

if [ -z "$1" ]; then
    PROJECT_DIR=$PWD
else
    PROJECT_DIR=$1
fi

BASE_OS="ubuntu"
USER_SETTING="-u $(id -u):$(id -g)"
PROJECT_MOUNT="-v ${PROJECT_DIR}:/project"
IMAGE="ghcr.io/cybernop/build-fhir-ig:$IGPUB_VERSION-$BASE_OS"
# DOCKER_OPTS="--pull always"
DOCKER_OPTS=""

docker run --rm $USER_SETTING $PROJECT_MOUNT $DOCKER_OPTS $IMAGE
