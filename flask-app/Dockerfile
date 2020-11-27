# pull official base image
FROM python:3.8.1-slim-buster

# set work directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# copy project
COPY entrypoint.sh /usr/src/app/
RUN chmod u+x /usr/src/app/entrypoint.sh

COPY . /usr/src/app/

RUN ls
#  EXPOSE ${APP_PORT}

# run entrypoint.sh
CMD ["/bin/bash", "/usr/src/app/entrypoint.sh"]
