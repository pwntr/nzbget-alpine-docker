#!/bin/sh

# we don't need GNU wget anymore (busybox' wget will still be available).
apk del wget

# also, clear the apk cache:
rm -rf /var/cache/apk/*
