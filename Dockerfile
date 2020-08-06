FROM debian:stable-slim
ENV PYTHON_VERSION=3.8.4
RUN apt-get update
RUN apt-get -y install wget
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
RUN tar xzvf Python-${PYTHON_VERSION}.tgz
RUN apt-get -y install make gcc libssl-dev zlib1g-dev libzip-dev \
    libsqlite3-dev libbz2-dev uuid-dev liblzma-dev libgdbm-dev \
    libreadline-dev

RUN cd Python-${PYTHON_VERSION} && \
    ./configure --prefix=/ && \
    make -j4 install DESTDIR=/opt/python${PYTHON_VERSION}

RUN cp -a /Python-${PYTHON_VERSION}/build/lib.linux-x86_64-3.8/* /opt/python${PYTHON_VERSION}/lib
COPY linux/copy_libs.py /
ENV PYTHONPATH=/opt/python${PYTHON_VERSION}/lib
RUN /opt/python${PYTHON_VERSION}/bin/python3 /copy_libs.py
