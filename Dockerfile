FROM mongo:3.7.9-xenial
RUN apt-get update

RUN apt-get -y install software-properties-common
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
		php7.2 \
		php7.2-gd \
		php7.2-pdo \
		php7.2-mysql \
		php7.2-mongodb \
		php7.2-dom \
		php7.2-sqlite
RUN apt-get install zip -y
RUN apt-get install libxrender1 -y
RUN apt-get install libfontconfig1 -y
RUN apt-get install libxtst6 -y
COPY php.ini /etc/php/7.2/cli