FROM python:3.14.0-alpine3.21

RUN pip install --no-cache-dir zensical

WORKDIR /workspace
