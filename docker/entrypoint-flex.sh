#!/bin/sh

echo "Configuration:"

if [ -z ${IGPUB_VERSION} ] ; then
  pubsource=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/
  echo "IG Publisher: latest"
else
  pubsource=https://github.com/HL7/fhir-ig-publisher/releases/download/$IGPUB_VERSION/
  echo "IG Publisher: $IGPUB_VERSION"
fi

publisher_jar=publisher.jar
dlurl=$pubsource$publisher_jar

if [ ! -z ${NPM_INSTALLED} ]; then
  if [ -z ${SUSHI_VERSION} ] ; then
    sushi_pkg=fsh-sushi
    echo "FSH Sushi: latest"
  else
    sushi_pkg=fsh-sushi@$SUSHI_VERSION
    echo "FSH Sushi: $SUSHI_VERSION"
  fi
else
  unset SUSHI_VERSION
fi

printf "\n\n"

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

echo "Downloading publisher - it's ~100 MB, so this may take a bit"
curl -L $dlurl -o "$publisher" --create-dirs

if [ ! -z ${NPM_INSTALLED} ]; then
  echo "Installing FSH Sushi"
  npm install --global fsh-sushi@${SUSHI_VERSION}
fi

printf "\n\n"

/root/genonce.sh $1
