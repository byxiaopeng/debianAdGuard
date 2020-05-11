FROM arm64v8/debian
#更新源
RUN apt-get -y update && apt-get -y upgrade
RUN apt install wget -y
RUN apt install dhcpcd5 -y
RUN apt install openssh-server -y
#同步系统时间
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN echo root:123456789 |chpasswd root


ADD AdGuardHome Ad/AdGuardHome
RUN chmod +x Ad/AdGuardHome

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT /configure.sh
EXPOSE 22 53 80 3000
