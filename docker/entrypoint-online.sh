#!/bin/sh

# Get IG Publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_updatePublisher.sh

if [ -z ${version} ] ; then
  pubsource=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/
else
  pubsource=https://github.com/HL7/fhir-ig-publisher/releases/download/$version/
fi

publisher_jar=publisher.jar
dlurl=$pubsource$publisher_jar

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

publisher=$HOME/$publisher_jar

echo "Downloading most recent publisher - it's ~100 MB, so this may take a bit"
curl -L $dlurl -o "$publisher" --create-dirs

/root/genonce.sh $1
