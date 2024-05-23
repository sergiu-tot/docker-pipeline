FROM python:3.10

RUN useradd jenkins -u 113 -m -s /bin/bash
ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip3 install '.[test]'
RUN rm -rf /tmp/flask-tutorial
