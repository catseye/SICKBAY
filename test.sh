#!/bin/sh

APPLIANCES=""
if command -v python2 > /dev/null 2>&1; then
    APPLIANCES="python2 $APPLIANCES"
    python2 script/SAWBONES -t || exit 1
fi
if command -v python3 > /dev/null 2>&1; then
    APPLIANCES="python3 $APPLIANCES"
    python3 script/SAWBONES -t || exit 1
fi

if [ "x$APPLIANCES" = "x" ]; then
    echo "No suitable Python versions found."
    exit 1
fi
