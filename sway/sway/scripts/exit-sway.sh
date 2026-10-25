#!/usr/bin/env bash
set -e

tmux kill-server || true

swaymsg exit
