FROM docker.io/ubuntu:18.04
MAINTAINER mr2jzgte@gmail.com

COPY neolink /usr/local/bin/
COPY watch-neolink /usr/local/bin/
COPY cron-neolink /etc/cron.d/


RUN true \
  export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  apt-utils

RUN true \
  export DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y --no-install-recommends \
    cron \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad \ 
  && apt-get install -y --no-install-recommends libgstrtspserver-1.0-0 libgstrtspserver-1.0-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean 

RUN true \
    crontab /etc/cron.d/cron-neolink 

EXPOSE 8554 
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

