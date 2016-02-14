#!/bin/sh

# check if config exists in /config. If it doesn't, copy the default on from the install dir.
if [ ! -f /config/nzbget.conf ]; then
  echo "No config found, copying the default config now."
  cp -v /nzbget/nzbget.conf /config/nzbget.conf
fi

# modify some options to match our container environment and use docker's logging only
sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
sed -i -e "s#\(WriteLog=\).*#\1none#g" /config/nzbget.conf
sed -i -e "s#\(ErrorTarget=\).*#\1screen#g" /config/nzbget.conf
sed -i -e "s#\(WarningTarget=\).*#\1screen#g" /config/nzbget.conf
sed -i -e "s#\(InfoTarget=\).*#\1screen#g" /config/nzbget.conf
sed -i -e "s#\(DetailTarget=\).*#\1none#g" /config/nzbget.conf
sed -i -e "s#\(DebugTarget=\).*#\1none#g" /config/nzbget.conf
