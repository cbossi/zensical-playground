FROM python:3.14.0-alpine3.21

RUN pip install --no-cache-dir zensical

# see README for why this is necessary
EXPOSE 8000/tcp

COPY ./content /workspace
WORKDIR /workspace
CMD zensical serve -a 0.0.0.0:8000
