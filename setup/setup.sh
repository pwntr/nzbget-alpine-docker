#!/bin/sh

# update the base system
apk update && apk upgrade

# we need the real (GNU) wget, the one incl. with Alpine's busybox is lacking some options
apk add wget

# add a non-root system (-S) user and group called "nzbget" with no password
addgroup -S nzbget && adduser -S -D nzbget -G nzbget

# create the install dir and volume mount points
mkdir /nzbget && mkdir /config && mkdir /downloads

# download the latest nzbget version
wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O /setup/nzbget-latest-bin-linux.run || \
echo "*** Download failed ***"

# let's install nzbget (defaults to the "/nzbget" directory)
sh /setup/nzbget-latest-bin-linux.run --destdir /nzbget

# check for and modify the config for our container
sh /setup/modify_config_for_container_env.sh

# change the owner accordingly
chown -R nzbget:nzbget /nzbget /config /downloads /setup/nzbget-latest-bin-linux.run
