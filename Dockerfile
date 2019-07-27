FROM python:slim-stretch

LABEL maintainer="tzinm"
LABEL version="1.0"

WORKDIR /home/

COPY AddToQbitTorrentFolder.py .

RUN \
 python3 -m pip install telegram --upgrade && \
 python3 -m pip install python-telegram-bot --upgrade && \
 chown root:root AddToQbitTorrentFolder.py && \
 chmod 644 AddToQbitTorrentFolder.py && \
 mkdir /zip/ && \
 mkdir descargas

VOLUME /home/descargas

CMD ["pyhton", "/home/AddToQbitTorrentFolder.py"]
