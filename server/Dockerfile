FROM python:3.12-slim-bookworm

ARG DEBIAN_FRONTEND=noninteractive

ENV GIT="/code"
ENV DIRECTORY="/code/server"
ENV LANG=C.UTF-8

RUN \
  DEPENDENCIES='\
    aptitude \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    curl \
    dialog \
    gcc \
    git \
    gnupg2 \
    g++ \
    htop \
    jq \
    locales \
    lsb-release \
    make \
    netcat-openbsd \
    openssh-client \
    pkg-config \
    poppler-utils \
    software-properties-common \
    supervisor \
    unzip \
    vim \
    wget \
    zip \
  ' && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y $DEPENDENCIES && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /usr/share/locale && \
  mkdir -p $DIRECTORY && \
  git config --global --add safe.directory $GIT && \
  echo "set mouse-=a" >> /root/.vimrc

COPY ./requirements/requirements.txt /tmp/requirements.txt
COPY ./requirements/requirements-docker.txt /tmp/requirements-docker.txt

RUN \
  pip install --upgrade pip setuptools wheel && \
  pip install -r /tmp/requirements-docker.txt

WORKDIR $DIRECTORY

CMD $DIRECTORY/scripts/run.sh
