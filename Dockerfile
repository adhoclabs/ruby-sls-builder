FROM ubuntu:focal

# setup timezone and filesystem
RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN mkdir -p /root/repo/assets
WORKDIR /root/repo/assets

# versioning and deb non-interactive fixes
ENV SERVERLESS_VERSION=1.45.1 \
    DEBIAN_FRONTEND="noninteractive" \
    DEBCONF_NONINTERACTIVE_SEEN="true"

# install OS deps
RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get upgrade -y \
    && apt-get install -y git awscli npm ruby ruby-dev zlibc zlib1g-dev libticonv-dev make gcc libpq-dev \
    && apt-get autoclean
    
# install serverless and deps
RUN npm i npm@latest -g \ 
    && npm install serverless@${SERVERLESS_VERSION} serverless-plugin-split-stacks serverless-prune-plugin serverless-api-gateway-cloudwatch-settings \
    && git clone https://github.com/douglasjsellers/serverless-plugins.git \
    && rm -rf serverless-plugins/.git \
    && npm install -i serverless-plugins/packages/serverless-offline-sqs \
    && git clone https://github.com/dmkr/serverless-offline-scheduler.git \
    && rm -rf serverless-offline-scheduler/.git \
    && npm install -i ./serverless-offline-scheduler

# install bundler
RUN gem install bundler
