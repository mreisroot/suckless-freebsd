#!/bin/sh

slstatus &
unclutter -idle 3 &
exec dwm
