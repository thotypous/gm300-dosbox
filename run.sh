#!/bin/sh
exec docker run --rm --device /dev/ttyUSB0:/dev/ttyUSB0 -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host -v ./backup:/gm300/backup -v ./repeater:/gm300/repeater gm300-dosbox
