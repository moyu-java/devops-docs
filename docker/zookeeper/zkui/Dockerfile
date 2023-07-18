FROM java:8
MAINTAINER moyu.jun

ENV PROJECT_NAME=zkui.jar 
ENV PROJECT_PORT=9090

ADD ./$PROJECT_NAME.jar /$PROJECT_NAME.jar 
ADD ./config.cfg /config.cfg

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

ENTRYPOINT java -jar /$PROJECT_NAME.jar

EXPOSE $PROJECT_PORT
