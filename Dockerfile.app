# start by pulling the python image
FROM python:3.8-alpine

# switch working directory
VOLUME ["/code"]
WORKDIR /code

# copy the requirements file into the image
COPY ./flask-tutorial/requirements.txt /code/requirements.txt

# install the dependencies and packages in the requirements file
RUN pip3 install -r requirements.txt

# configure the container to run in an executed manner
ENTRYPOINT [ "flask" ]

CMD [ "--app", "flaskr", "--host", "0.0.0.0", "run" ]
