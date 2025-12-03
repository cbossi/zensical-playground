FROM python:3.14.0-alpine3.21

RUN pip install --no-cache-dir zensical

# in order to be able to access zensical live preivew from the host machine, we would have to start 'zensical serve' as follows below:
# zensical serve -a 0.0.0.0:8000
# However, using the '-a' option breaks the live reload
# Hence, we use 'zensical serve' and create a proxy from port 8001 to port 8000 inside the contianer using socat.
# the port forwarding on the host then points to 8001 and socat 'redirects' to zensical running on 8000 and only visible in the container
RUN apk add --no-cache socat

COPY ./content /workspace
WORKDIR /workspace
CMD socat TCP-LISTEN:8001,fork,reuseaddr TCP:127.0.0.1:8000 & zensical serve
