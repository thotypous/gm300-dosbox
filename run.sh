#!/bin/sh
exec docker run --rm --device /dev/ttyUSB0:/dev/ttyUSB0 -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host gm300-dosbox
