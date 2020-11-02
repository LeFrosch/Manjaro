#!/usr/bin/env bash
killall conky
sleep 5s
conky -c "$HOME/.conky/conky.lua" &
