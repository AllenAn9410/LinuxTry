# docker build -t hello.dockerfile .
#use "$ docker images" examine you build image
#run container "docker run -p 4000:80 friendlyhello"


#use an offical python runtime as a parent image
FROM python:2.7-slim

#set the working directory to /app
WORKDIR /app

#copy the current directory contents into container at /app
ADD . /app

#install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

#make port 80 available to the world outside this container
EXPOSE 80

#define environment variable
ENV NAME world

#run app.py when the container launches
CMD ["python","app.py"]