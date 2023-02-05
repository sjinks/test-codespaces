#!/bin/sh

wp cache flush
wp db clean --yes
wp cache flush 2> /dev/null
/usr/local/bin/setup.sh
