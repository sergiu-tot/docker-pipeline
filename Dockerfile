FROM python:3.12

COPY flask-tutorial /tmp/

RUN cd /tmp/flask-tutorial && pip install '.[test]' && rm -rf /tmp/flask-tutorial
