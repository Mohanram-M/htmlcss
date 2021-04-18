#!/bin/bash

#$1-- root folder
#$2-- scss folder 
#$3-- css folder

SCRIPT_PATH="$(readlink --canonicalize-existing "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ];
then
    echo "Invalid command , expected rootfolder scssfolder cssfolder"
else
    IMG_NM=0mohan0ram/htmlcss
    SCSS_CSS_MAPP=/app/$1/$2:/app/$1/$3
    echo $SCRIPT_DIR/../$1:/app/$1
    docker build -t $IMG_NM -f $SCRIPT_DIR/Dockerfile $SCRIPT_DIR/
    docker run -e SCSS_CSS_MAPPING=$SCSS_CSS_MAPP -v $SCRIPT_DIR/../$1:/app/$1 -i -t $IMG_NM  npm run start:sasscompile

    CNT_NM=$(docker ps --filter ancestor=$IMG_NM --format="{{.ID}}")

    if [ ${#CNT_NM} -gt 0 ];
    then
        docker rm $(docker kill $CNT_NM)
        echo "clean up complete"
    else
        echo "clean up not required"
    fi

fi
