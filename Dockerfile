FROM python:3.12

RUN cd flask-tutorial && pip install '.[test]'
