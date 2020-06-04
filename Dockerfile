FROM docker.io/ubuntu:18.04
MAINTAINER mr2jzgte@gmail.com
COPY neo* /usr/local/bin/
COPY watch* /usr/local/bin/
COPY cron-neolink /etc/cron.d/


RUN echo 'Acquire::HTTP::Proxy "http://10.0.0.139:3142";' >> /etc/apt/apt.conf.d/01proxy \
 && echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy


RUN true \
  export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  apt-utils

RUN true \
  export DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y --no-install-recommends \
#    python-mutagen \
#    python-gi \
#    python-gi-cairo \
#    python-dbus \
#    gir1.2-gtk-3.0 \
#    gir1.2-gstreamer-1.0 \
#    gir1.2-gst-plugins-base-1.0 \
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

#CMD /bin/bash
