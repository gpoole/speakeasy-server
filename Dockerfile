FROM ubuntu:latest

COPY lib/kaldi /usr/lib/kaldi
COPY lib/kaldi-gstreamer-server /usr/lib/kaldi-gstreamer-server
COPY bin/install-speakeasy-server /usr/bin/install-speakeasy-server
COPY bin/speakeasy-server /usr/bin/speakeasy-server
COPY etc/speakeasy.conf /etc/supervisor/conf.d/speakeasy.conf
RUN chmod +x /usr/bin/install-speakeasy-server /usr/bin/speakeasy-server

RUN /usr/bin/install-speakeasy-server

ENTRYPOINT /usr/bin/speakeasy-server

EXPOSE 8000