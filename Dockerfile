FROM ubuntu:20.04

LABEL version="1.0"
LABEL maintainer = ["lucasbarbosagomes0@gmail.com"]

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE true

# Initial setup. Node is a fucking pain.
RUN DEBIAN_FRONTEND="noninteractive" \
    apt-get -y update && \
    apt-get -y install \
        curl \
        gnupg \
        tzdata \
    && \
    # Add Node and Yarn PPAs
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    cp /etc/apt/sources.list /etc/apt/sources.list~ && sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && \
    apt-get update && \
    # Install stuff
    apt-get -y install \
        ca-certificates \
        curl \
        ffmpeg \
        git \
        build-essential \
        checkinstall \
        libx11-dev \
        libxext-dev \
        zlib1g-dev \
        libpng-dev \
        libjpeg-turbo8-dev \
        libjpeg8-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libxml2-dev \
        libtiff-dev \
        imagemagick \
        golang \
        hugo \
        jekyll \
        make \
        nodejs \
        python3-pip \
        python3-venv \
        python3.8 \
        trimage \
        wget \
        xvfb \
        pngquant \
    && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.imagemagick.org/download/ImageMagick.tar.gz && \
    tar xvzf ImageMagick.tar.gz && cd ImageMagick-* && ./configure --disable-shared && sudo make && sudo make install && sudo make check

# Python. Not symlinking causes poetry to barf :/
# It also does this if python3-venv is not installed.
RUN pip3 install --upgrade \
        awscli \
        requests \
        black \
        poetry

# Node. This adds "1536 packages from 745 contributors".
RUN npm i -g \
        eslint \
        inline-source-cli \
        parcel-bundler \
        prettier \
        @11ty/eleventy \
        yarn

# Go!
ENV GOPATH $HOME/go
ENV PATH $HOME/go/bin:$PATH
RUN go get -u \
        github.com/tcnksm/ghr
