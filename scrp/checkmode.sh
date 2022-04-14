#!/bin/bash

iface=$(airmon-ng | awk 'NR==4' | awk '{print $2}')

echo $iface

