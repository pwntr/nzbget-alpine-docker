FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>

# list of packages to be added to the alpine base image (separate by space)
ENV PACKLIST="wget"

# install the software defined in PACKLIST
RUN apk add --update $PACKLIST && rm -rf /var/cache/apk/*

# download the latest nzbget version
RUN wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run || \
echo "*** Download failed ***"

# let's install it (defaults to the "nzbget directory") and delete the installer afterwards
RUN sh nzbget-latest-bin-linux.run && rm nzbget-latest-bin-linux.run

# and off we go!
RUN nzbget/nzbget -s -o OutputMode=log

# just placeholders for now
#ADD init/ /etc/my_init.d/
#ADD services/ /etc/service/
#RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# useful mappings
VOLUME /config /downloads /logs

EXPOSE 6789
