#!/bin/bash

set -e

FILE=$1
TO_ENCODING="UTF-8";
FROM_ENCODING=$(file -i $FILE | cut -d '=' -f2);

if [[ ! $FROM = "binary" ]]; then
	echo "Converting..."
	iconv -f $FROM_ENCODING -t $TO_ENCODING -o $FILE.tmp $FILE;
	mv -f $FILE.tmp $FILE;
	echo "DONE"
fi
