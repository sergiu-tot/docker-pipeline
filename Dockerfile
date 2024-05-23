FROM python:3.12

RUN cd examples/tutorial && pip install '.[test]'
