FROM arm64v8/debian
#更新源
RUN apt-get -y update && apt-get -y upgrade
RUN apt install wget -y
RUN apt install dhcpcd5 -y
#同步系统时间
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT /configure.sh
EXPOSE 53 80 3000
