#!/bin/sh

# Run IG Publisher
# parts taken from https://github.com/HL7/ig-publisher-scripts/blob/main/_genonce.sh

#!/bin/bash
publisher_jar=publisher.jar
input_cache_path=/root/
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

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8"

PROJECT_DIR=$1
cd $PROJECT_DIR

publisher=$input_cache_path/$publisher_jar
if test -f "$publisher"; then
    java -jar $publisher -ig . -no-sushi $txoption $*

else
    echo IG Publisher NOT FOUND. Aborting...
fi
