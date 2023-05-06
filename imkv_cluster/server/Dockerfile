FROM xcq0826/ec-based:v2
LABEL maintainer="xcq"
WORKDIR /home/xcq/imkv/server
RUN su xcq
COPY ./server ./
COPY ./start-server.sh ./
EXPOSE 9111/tcp 4803/tcp 22/tcp
#FROM imkv_base:v4