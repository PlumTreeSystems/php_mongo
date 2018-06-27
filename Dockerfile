FROM mongo:3.7.9-xenial
RUN apt-get update

RUN apt-get -y install software-properties-common
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
		curl \
		php7.2 \
		php7.2-gd \
		php7.2-pdo \
		php7.2-mysql \
		php7.2-mongodb \
		php7.2-dom \
		php7.2-sqlite \
		php7.2-mbstring \
		php7.2-zip \
		apt-transport-https \
		php-pear \
		php7.2-dev \
		libssl-ocaml-dev \
		libssl-dev
RUN apt-get install zip -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get install libxrender1 -y
RUN apt-get install libfontconfig1 -y
RUN apt-get install libxtst6 -y
RUN mkdir /cache && /bin/bash -c 'chmod -R 777 /cache'
COPY php.ini /etc/php/7.2/cli

RUN echo -e "; \nextension=pdo.so" >> /etc/php/7.2/cli/php.ini

# MSSQL
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install msodbcsql17 -y \
    && apt-get install unixodbc-dev -y \
    && pecl install pdo_sqlsrv \
    && echo -e "; priority=20\nextension=pdo_sqlsrv.so" >> /etc/php/7.2/cli/php.ini