FROM python:3.10

VOLUME ["/code"]
WORKDIR /code
ADD flask-tutorial /tmp/flask-tutorial/
RUN cd /tmp/flask-tutorial && pip3 install '.[test]' && pip3 install coverage bandit pylint
RUN rm -rf /tmp/flask-tutorial
