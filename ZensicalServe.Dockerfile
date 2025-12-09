FROM python:3.14.0-alpine3.21

RUN pip install --no-cache-dir zensical

# see README.md
RUN apk add --no-cache socat

COPY ./content /workspace
WORKDIR /workspace
CMD socat TCP-LISTEN:8001,fork,reuseaddr TCP:127.0.0.1:8000 & zensical serve
