
FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
#更新源
RUN apk update && apk upgrade
RUN apk add wget tzdata dhcpcd5
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

RUN wget https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz
RUN tar  -zxvf AdGuardHome_linux_arm64.tar.gz
RUN rm -r AdGuardHome_linux_arm64.tar.gz
RUN mv /AdGuardHome/AdGuardHome /usr/bin/AdGuardHome
RUN chmod +x /usr/bin/AdGuardHome

VOLUME /AdGuardHome

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 53 80 3000
