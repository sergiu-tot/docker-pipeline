FROM python:3.10

ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip3 install '.[test]' && pip3 install coverage bandit
RUN rm -rf /tmp/flask-tutorial
