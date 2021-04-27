FROM python:3.9.0-slim-buster

ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get -y install curl build-essential libssl-dev \
    && apt-get clean \
    && pip install --upgrade pip

RUN pip3 install Cython numpy

# Prepare environment
RUN mkdir /jesse-docker
WORKDIR /jesse-docker

# Install TA-lib
COPY build_helpers/* /tmp/
RUN cd /tmp && /tmp/install_ta-lib.sh && rm -r /tmp/*ta-lib*

# Install dependencies
RUN pip3 install -r https://raw.githubusercontent.com/jesse-ai/jesse/master/requirements.txt

# Install jesse
RUN pip3 install jesse

ENTRYPOINT ["tail", "-f", "/dev/null"]
