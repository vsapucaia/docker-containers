FROM ubuntu:16.04

# requirements
RUN sed -e s%http://archive.ubuntu.com/ubuntu/%mirror://mirrors.ubuntu.com/mirrors.txt% -i /etc/apt/sources.list \
        && apt-get update \
        && apt-get dist-upgrade -y \
        && apt-get install -y python-setuptools python-pip bzip2 \           
            # this line is not needed on hosteurope
            git nano python3 tar wget zip unzip apache2 \ 
            # #######
            gdal-bin libgdal1-dev dh-autoreconf \
            fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted ttf-unifont \
            libboost-all-dev build-essential autoconf libtool libxml2-dev libgeos-dev \
            libgeos++-dev libpq-dev libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev \
            protobuf-c-compiler libfreetype6-dev libpng12-dev libtiff5-dev libicu-dev \
            libgdal-dev libcairo-dev libcairomm-1.0-dev apache2-dev libagg-dev \
            liblua5.2-dev lua5.1 liblua5.1-dev libgeotiff-epsg

# mapnik and mapnik-python
ENV MAPNIK_VERSION=3.0.9+ds-1 \
    PYTHON_MAPNIK_VERSION=1:0.0~20151125-92e79d2-1build1
RUN apt-get update \
 && apt-get install -y \
            libmapnik3.0=${MAPNIK_VERSION} \
            libmapnik-dev=${MAPNIK_VERSION} \
            mapnik-utils=${MAPNIK_VERSION} \
            python-mapnik=${PYTHON_MAPNIK_VERSION} \
            python3-mapnik=${PYTHON_MAPNIK_VERSION} \
     && python -c 'import mapnik'

# mod_tile
RUN cd /usr/src \
    && git clone git://github.com/SomeoneElseOSM/mod_tile.git \
    && cd mod_tile \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && make install-mod_tile \
    && ldconfig

# osm style
RUN cd /usr/src \
    && git clone git://github.com/gravitystorm/openstreetmap-carto.git \
    && cd openstreetmap-carto \
    && apt-get install -y npm nodejs-legacy \
    && npm install -g carto \
    && carto project.mml > mapnik.xml

# HOMEDAY services
# RUN cd /usr/src \
#     && git clone https://github.com/homeday-de/mapnik.git \
    # && cd mapnik \
    # && wget http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip \
    # && wget http://data.openstreetmapdata.com/land-polygons-split-3857.zip \
    # && unzip simplified-land-polygons-complete-3857.zip \
    # && unzip land-polygons-split-3857.zip \
    # && rm *.zip \
    # && shapeindex simplified-land-polygons-complete-3857/simplified_land_polygons.shp \
    # && shapeindex land-polygons-split-3857/land_polygons.shp

# configure renderd
#RUN cp /usr/local/etc/renderd.conf /usr/local/etc/renderd.conf.original \
#    && cp /usr/src/mapnik/_renderd/renderd.conf /usr/local/etc/renderd.conf

# TILEDIR
# REPLACE   tile_dir=/data/var/lib/mod_tile
#   to      tile_dir=/var/lib/mod_tile
# REPLACE   tiledir=/data/var/lib/mod_tile
#   to      tiledir=/var/lib/mod_tile
# XML
# REPLACE   XML=/home/renderer/src/
#   to      XML=/usr/src/

# configuring Apache
RUN mkdir /var/lib/mod_tile \
    && mkdir /var/run/renderd \
    && echo "LoadModule tile_module /usr/lib/apache2/modules/mod_tile.so" >> /etc/apache2/conf-available/mod_tile.conf \
    && a2enconf mod_tile
ADD apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN service apache2 start \
    && service apache2 reload \
    && service apache2 reload