#!/bin/bash


ewr() {
    sleep 0.05
    echo -e "$@"
}

#change link to cora link

check_for_updates () {
    ewr "Checking for updates"
        while [ "$(git stash --include-untracked | git reset --hard | git pull https://github.com/clu3bot/cora.git > git.txt)" ]; do
            ewr "[Checking updates for Cora]"
                ewr "\nPlease wait.."
        done;
        if grep "Already" git.txt; then
            ewr "Cora is already up to date!"
                rm -rf git.txt
                sleep 0.2
        else
            ewr "Cora has been updated. Restart script for changes to take place."
            sleep 1
            rm -rf git.txt
            exit
        fi
}

initital() {
    check_for_updates
}
