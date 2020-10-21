#!/usr/bin/env bash
killall conky
sleep 5s
python "$Home/.conky/calender.py"
conky -c "$HOME/.conky/conky.lua" &
