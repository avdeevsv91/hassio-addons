ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/latest-stable/community ffmpeg

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]