# nzbget-alpine-docker
A simple and super lightweight nzbget docker container, based on the latest Alpine Linux base image 🐧🐋💻.

Always shipped with the latest nzbget stable version!

Run it:
```shell
docker run -d -p 6789:6789 -v /path/to/config:/config -v /path/to/downloads:/downloads pwntr/nzbget-alpine
```
