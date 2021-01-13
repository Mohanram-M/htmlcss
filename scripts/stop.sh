#!/bin/sh
IMG_NM=0mohan0ram/htmlcss
CNT_NM=$(docker ps --filter ancestor=$IMG_NM --format="{{.ID}}")

if [ ${#CNT_NM} -gt 0 ];
then
    docker rm $(docker kill $CNT_NM)
    echo "clean up complete"
else
    echo "clean up not required"
fi