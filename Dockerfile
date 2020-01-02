FROM centos:latest
RUN mkdir -p /app/jdk-home && \
    mkdir -p /app/my-spring-boot
ADD ./jdk-8u181-linux-x64.tar.gz "/app/jdk-home"
ENV JAVA_HOME=/app/jdk-home/jdk1.8.0_181
ENV PATH=$PATH:${JAVA_HOME}/bin
WORKDIR /app/my-spring-boot