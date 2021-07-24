ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories
RUN apk update

RUN apk add --no-cache ffmpeg

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]