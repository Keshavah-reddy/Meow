FROM alpine:latest
LABEL MAINTAINER="https://github.com/Keshavah-reddy/Meow"
WORKDIR /Meow/
ADD . /Meow
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./Meow.sh"
