FROM python:3.14.0-alpine3.21

RUN pip install --no-cache-dir zensical

WORKDIR /workspace
# see README for why the copy action is necessary
CMD cp -r . /workspace-temp;cd /workspace-temp;zensical build;rm -rf /workspace/site;cp -r . /workspace;cd /workspace/site
