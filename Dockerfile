FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>
LABEL Description="Simple and lightweight nzbget docker container, based on Alpine Linux." Version="0.1"

# update the base system
RUN apk update && apk upgrade

# we need the real wget, the one incl. with Alpine's busybox is lacking some options
RUN apk add wget

# download the latest nzbget version
RUN wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run || \
echo "*** Download failed ***"

# let's install it (defaults to the "nzbget" directory) and delete the installer file afterwards
RUN sh nzbget-latest-bin-linux.run && rm nzbget-latest-bin-linux.run

# useful mappings
VOLUME /config /downloads /logs

# exposes nzbget's default port
EXPOSE 6789

# set some defaults and start nzbget in server and log mode
ENTRYPOINT ["nzbget/nzbget", "-s", "-o", "OutputMode=log"]
