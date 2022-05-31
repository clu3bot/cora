#!/bin/bash

i=$(sudo python3 scrp/inthandler/rename.py)

sudo airmon-ng start $i