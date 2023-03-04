#!/bin/bash

# create /var/log/auth.log if not exist

if [ ! -e /var/log/auth.log ]; then
touch /var/log/auth.log
fi

# start ssh service

service ssh start

# Link auth.log to container log
tail -f /var/log/auth.log