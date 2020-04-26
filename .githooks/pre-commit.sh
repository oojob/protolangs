#!/bin/sh
#
# Created on Sun Apr 26 2020
#
# Base entity related messages.
# This file is resposible for storing all the base protobuff `message`.
#
# @authors nirajgeorgian@oojob.io (Niraj Kishore)
#
# Copyright (c) 2020 - oojob

# Specify the directory for the hooks.
# We'll use the current one (.githooks)
hookDir=$(dirname $0)

# Specify the hooks you want to run during
# the pre-commit process:
"$hookDir/areYouSure.sh"
# && "hookDir/add-your-own-scripts-here"