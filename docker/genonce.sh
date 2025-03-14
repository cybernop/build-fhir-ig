#!/bin/sh

publisher_jar=publisher.jar
publisher=$HOME/$publisher_jar

# Get project dir from CLI
PROJECT_DIR=$1
WORKSPACE=$HOME/workspace
OUTPUT_DIR=/output

mkdir -p $WORKSPACE

printf "\nCopy files to working directory..."
cp -r $PROJECT_DIR/* $WORKSPACE

cd $WORKSPACE

# Only remove this folder when building with sushi
if [ ! -z ${SUSHI_VERSION} ] ; then
    rm -rf fsh-generated
fi

rm -rf input-cache
rm -rf output
rm -rf temp
rm -rf template
printf " done\n\n"

# Download and inflate the FHIR packages if building profiles with FSH Sushi
if [ ! -z ${SUSHI_VERSION} ] ; then
    printf "\n\nInstall and inflate FHIR packages...\n"
    fhir restore
    printf "\n...done!\n\n"

fi

if [ -z ${SUSHI_VERSION} ] ; then
    NO_SUSHI=-no-sushi
fi

# Build arguments for IG Publisher
if [ ! -z "${PUBLISH_URL}" ]; then
    PUBLISH="-publish ${PUBLISH_URL}"
fi

# Run IG Publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_genonce.sh

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8"

if test -f "$publisher"; then
    java -jar $publisher -ig . $NO_SUSHI $PUBLISH
else
    echo IG Publisher NOT FOUND. Aborting...
fi

# Build the archive and move it to the output folder
printf "\nBuild IG archive at $OUTPUT_DIR/ig.zip..."
zip -q -r ig.zip output
cp -f ig.zip $OUTPUT_DIR
cp -f /tmp/fhir-ig-publisher-tmp.log $OUTPUT_DIR
printf "done\n\n"
