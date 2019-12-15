FROM python:3.8

WORKDIR /python
RUN apt -y update  && \
    apt -y install jq && \
    pip install yq