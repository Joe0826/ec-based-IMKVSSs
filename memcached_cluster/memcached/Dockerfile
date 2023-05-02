FROM xcq0826/ec-based:v1
LABEL maintainer="xcq"
WORKDIR /home/xcq/workspace/memcached_cluster
RUN su xcq
COPY ./start-memcached.sh ./
EXPOSE 22/tcp 11211/tcp
#FROM memcached_cluster:v1