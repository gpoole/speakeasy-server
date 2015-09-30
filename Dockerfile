FROM ubuntu:latest

COPY lib /usr/lib/speakeasy/lib
# COPY lib/kaldi-gstreamer-server /usr/lib/kaldi-gstreamer-server
# COPY lib/gst-kaldi-nnet2-online /usr/lib/gst-kaldi-nnet2-online
COPY bin/install-speakeasy-server /usr/bin/install-speakeasy-server
COPY bin/speakeasy-server /usr/bin/speakeasy-server
COPY etc/speakeasy/speakeasy.conf /etc/supervisor/conf.d/speakeasy.conf
RUN chmod +x /usr/bin/install-speakeasy-server /usr/bin/speakeasy-server

RUN SPEAKEASY_ROOT=/usr/lib/speakeasy/ /usr/bin/install-speakeasy-server

ENTRYPOINT /usr/bin/speakeasy-server

EXPOSE 8000
