FROM python:3.10

USER 113
ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip install '.[test]' && rm -rf /tmp/flask-tutorial
