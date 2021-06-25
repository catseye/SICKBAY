#!/bin/sh

python2 script/SAWBONES -t || exit 1
python3 script/SAWBONES -t || exit 1
