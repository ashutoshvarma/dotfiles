#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr  --auto

echo $(date) >>  ~/gdm-optimus.log
