FROM ubuntu:16.04

RUN apt-get update \
#    && apt-get dist-upgrade -y

ENV MAPNIK_VERSION=v3.0.11

RUN apt-get build-dep -y libmapnik3.0 \
    && apt-get install -y git ca-certificates \
    && git clone --depth 1 --branch $MAPNIK_VERSION https://github.com/mapnik/mapnik.git \
    && cd mapnik \
    && git submodule update --init \
    && ./configure \
    && make \
    && make install \
    && cd - 

    autoconf apache2-dev libtool libxml2-dev libbz2-dev libgeos-dev libgeos++-dev libproj-dev gdal-bin libgdal1-dev libmapnik-dev mapnik-utils python-mapnik