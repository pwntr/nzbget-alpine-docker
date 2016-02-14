FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>
LABEL Description="Simple and lightweight nzbget docker container, based on Alpine Linux." Version="0.1"

# copy init files
RUN mkdir /setup
COPY setup/* /setup/

# make the escripts executable and run the setup
RUN chmod -v +x setup/*.sh && sh setup/setup.sh

# delete all the setup files
RUN setup/cleanup.sh && rm -r /setup/

# volume mappings
VOLUME /config /downloads

# exposes nzbget's default port
EXPOSE 6789

# not root anymore going forward
USER nzbget

# set some defaults and start nzbget in server and log mode
ENTRYPOINT ["nzbget/nzbget", "-s", "-o", "OutputMode=log", "-c", "/config/nzbget.conf"]
