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

# Check that we want to commit.

read -p "Are you sure you want to commit this (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        exit 0 # If yes, success!
    ;;
    * )
        exit 1 # If no, sorry yo.
    ;;
esac