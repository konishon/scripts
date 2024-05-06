#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install ffmpeg imagemagick 


# Start recording (Output to current directory)
ffmpeg -f x11grab -video_size $(xdpyinfo | grep dimensions | awk '{print $2}') \
       -i $DISPLAY -f pulse -i default "recording-$(date +%Y%m%d-%H%M%S).mkv" &
recording_pid=$!


# Stop function 
stop_recording() {
  kill $recording_pid
  ntfy send -t "$ntfy_topic" "Recording stopped."
}


trap stop_recording SIGINT SIGTERM 
