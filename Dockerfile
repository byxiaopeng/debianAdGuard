#FROM arm64v8/debian
FROM arm64v8/alpine
RUN apk update
RUN apk upgrade

RUN apk add wget
RUN apk add curl
RUN apk add bash
RUN apk add dhcp
#同步系统时间
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata

#更新源
#RUN apt-get -y update && apt-get -y upgrade
#RUN apt install wget -y
#RUN apt install dhcpcd5 -y
#RUN apt install openssh-server -y
#同步系统时间

#RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
#RUN echo root:123456789 |chpasswd root
RUN wget https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz
RUN tar  -zxvf AdGuardHome_linux_arm64.tar.gz
RUN rm -r AdGuardHome_linux_arm64.tar.gz
RUN chmod +x /AdGuardHome/AdGuardHome
ADD AdGuardHome.yaml /AdGuardHome/AdGuardHome.yaml

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT /configure.sh
EXPOSE 22 53 80 3000
