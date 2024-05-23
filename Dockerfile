FROM python:3.10

RUN useradd jenkins -u 113 -m -s /bin/bash
USER jenkins
ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip3 install '.[test]'
USER root
RUN rm -rf /tmp/flask-tutorial
