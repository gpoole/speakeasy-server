FROM ubuntu:latest

COPY lib /usr/lib/speakeasy/lib
# COPY lib/kaldi-gstreamer-server /usr/lib/kaldi-gstreamer-server
# COPY lib/gst-kaldi-nnet2-online /usr/lib/gst-kaldi-nnet2-online
COPY bin/install-speakeasy-server /usr/bin/install-speakeasy-server
COPY bin/speakeasy-server /usr/bin/speakeasy-server
RUN sed -i"" -e 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirror.optus.net\/ubuntu\//g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y curl
RUN curl http://www.digip.org/jansson/releases/jansson-2.7.tar.bz2 | tar -jxC /usr/src
RUN curl https://phon.ioc.ee/~tanela/tedlium_nnet_ms_sp_online.tgz | tar zxv -C /usr/lib/speakeasy/lib/kaldi-gstreamer-server/test/models
RUN apt-get install -y \
	build-essential supervisor make python-setuptools python-dev python-yaml \
	python-anyjson python-gi libgstreamer1.0-dev gstreamer1.0-plugins-good \
	gstreamer1.0-tools gstreamer1.0-pulseaudio automake libtool autoconf wget \
	git subversion libatlas3-base
RUN chmod +x /usr/bin/install-speakeasy-server /usr/bin/speakeasy-server

RUN SPEAKEASY_ROOT=/usr/lib/speakeasy/ /usr/bin/install-speakeasy-server
COPY etc/speakeasy/speakeasy.conf /etc/supervisor/conf.d/speakeasy.conf

ENTRYPOINT /usr/bin/speakeasy-server

EXPOSE 8000
