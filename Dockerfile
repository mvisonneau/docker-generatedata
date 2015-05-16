# generatedata
# Author : Maxime VISONNEAU - @mvisonneau
#
# VERSION 0.1
# 	

FROM tutum/apache-php
RUN apt-get update && \
	apt-get install -yq git php5-dev libpcre3-dev && \
	rm -rf /var/lib/apt/lists/*
RUN	a2enmod rewrite