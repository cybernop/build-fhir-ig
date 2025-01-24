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
# rm -r fsh-generated
rm -r input-cache
rm -r output
rm -r temp
rm -r template
printf " done\n\n"

# Run IG Publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_genonce.sh

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8"

if test -f "$publisher"; then
    java -jar $publisher -ig . -no-sushi
else
    echo IG Publisher NOT FOUND. Aborting...
fi

# Build the archive and move it to the output folder
printf "\nBuild IG archive at $OUTPUT_DIR/ig.zip..."
zip -q -r ig.zip output
cp -f ig.zip $OUTPUT_DIR
printf "done\n\n"
