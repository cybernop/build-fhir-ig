#!/bin/sh

PROJECT_DIR=$1
cd $PROJECT_DIR

# Get publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_updatePublisher.sh
pubsource=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/
publisher_jar=publisher.jar
dlurl=$pubsource$publisher_jar

input_cache_path=$PWD/input-cache/

skipPrompts=false
FORCE=false

if ! type "curl" > /dev/null; then
	echo "ERROR: Script needs curl to download latest IG Publisher. Please install curl."
	exit 1
fi

echo "Checking internet connection"
curl -sSf tx.fhir.org > /dev/null

if [ $? -ne 0 ] ; then
  echo "Offline (or the terminology server is down), unable to update.  Exiting"
  exit 1
fi

if [ ! -d "$input_cache_path" ] ; then
  mkdir ./input-cache
fi

publisher="/root/$publisher_jar"

echo "Downloading most recent publisher - it's ~100 MB, so this may take a bit"
curl -L $dlurl -o "$publisher" --create-dirs
