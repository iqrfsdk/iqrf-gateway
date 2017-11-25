# IQRF GW image for the UP board
# Authors: JotioTech s.r.o. && IQRFTech s.r.o.

FROM resin/up-board-debian:stretch

MAINTAINER Rostislav Spinar <rostislav.spinar@iqrf.com>
LABEL maintainer="rostislav.spinar@iqrf.com"

# add iqrf repo
RUN echo "deb http://repos.iqrfsdk.org/debian stretch testing" | sudo tee -a /etc/apt/sources.list.d/iqrf-daemon.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F973CFCE6B3BE25C

# install supervisor && mosquitto && iqrf-daemon && php && nginx && node.js
RUN apt-get update \
 && apt-get install --no-install-recommends -y apt-utils apt-transport-https build-essential composer curl git iqrf-daemon lsb-release mosquitto php7.0 php7.0-common php7.0-curl php7.0-fpm php7.0-json php7.0-mbstring php7.0-sqlite php7.0-zip nginx-full supervisor unzip wget \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install --no-install-recommends -y nodejs \
 && mkdir -p  /var/run/sshd /var/log/supervisor \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install iqrf-webapp
WORKDIR /var/www/iqrf-daemon-webapp
RUN composer create-project iqrfsdk/iqrf-daemon-webapp . dev-master
RUN sed -i 's/sudo\:\ true/sudo\:\ false/g' app/config/config.neon \
 && sed -i 's/iqrf-gw\:\ false/iqrf-gw\:\ true/g' app/config/config.neon \
 && sed -i "s/initDaemon: 'systemd'/initDaemon: 'docker-supervisor'/g" app/config/config.neon
RUN cat app/config/config.neon

# install node-red dashboard
RUN npm install -g --unsafe-perm node-red \
 && npm install -g --unsafe-perm node-red/node-red-dashboard

# copy custom configuration
WORKDIR /etc/nginx/sites-available
COPY nginx/localhost .
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost && rm /etc/nginx/sites-enabled/default
WORKDIR /etc/supervisor/conf.d
COPY supervisor/supervisord.conf .
WORKDIR /etc/iqrf-daemon
COPY config/. .
RUN mkdir -p /node-red
WORKDIR /node-red
COPY ui/settings.js .
COPY ui/flows.json .

# expose ports
EXPOSE 80 1880 1883 8080 9001 55000/udp 55300/udp

# run the supervisor service
CMD ["/usr/bin/supervisord"]
