# Image de base
FROM ubuntu:latest

# Installation des packages Python avec apt-get
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    vim \
    python-pip \
    python-setuptools \
    python3 \
    python3-pip \
    python3-setuptools \
    git \
&& pip install --upgrade pip \
&& pip install wheel \
&& pip install nose nosexcover pylint setuptools-lint pycodestyle tox mock \
&& pip3 install --upgrade pip \
&& pip3 install wheel \
&& pip3 install nose nosexcover pylint setuptools-lint pycodestyle tox mock \
&& rm -rf /var/lib/apt/lists/*

# Changement du repertoire courant
WORKDIR /devpython

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
