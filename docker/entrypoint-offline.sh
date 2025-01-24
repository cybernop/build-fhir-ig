#!/bin/sh

# Run IG Publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_genonce.sh

#!/bin/bash
publisher_jar=publisher.jar
input_cache_path=$HOME/
echo Checking internet connection...
curl -sSf tx.fhir.org > /dev/null

if [ $? -eq 0 ]; then
    echo "Online"
    txoption=""
else
    echo "Offline"
    txoption="-tx n/a"
fi

echo "$txoption"

/root/genonce.sh $1
