FROM python:3.12

ADD flask-tutorial /tmp/flask-tutorial/

RUN find /tmp/

RUN cd /tmp/flask-tutorial && pip install '.[test]' && rm -rf /tmp/flask-tutorial
