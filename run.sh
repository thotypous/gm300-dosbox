#!/bin/sh
exec docker run --rm \
    --device /dev/ttyUSB0 --annotation run.oci.keep_original_groups=1 \
    -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net host \
    -v ./backup:/gm300/backup -v ./repeater:/gm300/repeater \
    thotypous/gm300-dosbox
