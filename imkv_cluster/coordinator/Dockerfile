FROM xcq0826/ec-based:v2
LABEL maintainer="xcq"
WORKDIR /home/xcq/imkv/coordinator
RUN su xcq
COPY ./coordinator ./
COPY ./start-coordinator.sh ./
EXPOSE 9110/tcp 4803/tcp 22/tcp
#FROM imkv_base:v4