FROM arm32v7/python:3-alpine

LABEL maintainer="tzinm" \
      version="1.0" \
      system="arm"

WORKDIR /home/

COPY AddToQbitTorrentFolder.py .

RUN \
 apk update && \
 apk add gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev && \
 pip install --upgrade pip && \
 python3 -m pip install telegram --upgrade && \
 python3 -m pip install python-telegram-bot --upgrade && \
 chown root:root AddToQbitTorrentFolder.py && \
 chmod 644 AddToQbitTorrentFolder.py && \
 mkdir /zip/ && \
 mkdir descargas

VOLUME /home/descargas

CMD ["python", "/home/AddToQbitTorrentFolder.py"]
