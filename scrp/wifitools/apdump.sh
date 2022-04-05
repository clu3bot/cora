#!/bin/bash


getvar() {
    int=$(cat tmp/int.txt)
}

apdump() {
    sudo airmon-ng start ${int}
    sudo airodump-ng start ${int}

}

initial() {
getvar
apdump
}

initial