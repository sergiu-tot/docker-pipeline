FROM python:3.10

ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip3 install '.[test]'
RUN rm -rf /tmp/flask-tutorial
