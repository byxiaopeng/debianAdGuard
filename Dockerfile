FROM arm64v8/alpine
RUN apk update
RUN apk upgrade
RUN apk add wget vim curl bash dhcpcd

#同步系统时间
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata

RUN wget https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz
#RUN wget https://static.adguard.com/adguardhome/edge/AdGuardHome_linux_arm64.tar.gz
RUN tar  -zxvf AdGuardHome_linux_arm64.tar.gz
RUN rm -r AdGuardHome_linux_arm64.tar.gz
RUN mv /AdGuardHome/AdGuardHome /usr/bin/AdGuardHome
RUN chmod +x /usr/bin/AdGuardHome

VOLUME /AdGuardHome

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 22 53 80 3000


#FROM arm64v8/debian
#更新源
#RUN apt-get -y update && apt-get -y upgrade
#RUN apt -y install wget dhcpcd5 openssh-server

#RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
#RUN echo root:123456789 |chpasswd root
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
