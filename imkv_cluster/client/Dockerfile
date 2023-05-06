FROM xcq0826/ec-based:v2
LABEL maintainer="xcq"
WORKDIR /home/xcq/imkv/client
RUN su xcq
COPY ./client ./
COPY ./start-client.sh ./
EXPOSE 9112/tcp 4803/tcp 22/tcp
#FROM imkv_base:v4