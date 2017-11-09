FROM ubuntu:16.04

RUN sed -e s%http://archive.ubuntu.com/ubuntu/%mirror://mirrors.ubuntu.com/mirrors.txt% -i /etc/apt/sources.list \
        && apt-get update \
        && apt-get dist-upgrade -y \
        && apt-get install -y nano \
        	apache2-dev libtool libxml2-dev libbz2-dev libgeos-dev libgeos++-dev \
        	libproj-dev gdal-bin libgdal1-dev libmapnik-dev mapnik-utils python-mapnik

ENV MAPNIK_VERSION=v3.0.9

RUN apt-get build-dep -y libmapnik3.0 \
    && apt-get install -y git ca-certificates \
    && git clone --depth 1 --branch $MAPNIK_VERSION https://github.com/mapnik/mapnik.git \
    && cd mapnik \
    && git submodule update --init \
    && ./configure \
    && make \
    && make install \
    && cd -

RUN apt-get install -y python-setuptools python-pip

RUN git clone --depth 1 https://github.com/mapnik/python-mapnik.git
	
RUN cd python-mapnik \
	&& python setup.py install