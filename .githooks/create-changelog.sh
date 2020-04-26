#!/usr/bin/env bash
#
# Created on Sun Apr 26 2020
#
# Base entity related messages.
# This file is resposible for storing all the base protobuff `message`.
#
# @authors nirajgeorgian@oojob.io (Niraj Kishore)
#
# Copyright (c) 2020 - oojob

# create a changelog

git log --pretty="- %s" > CHANGELOG.md
exit 0