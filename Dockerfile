FROM ubuntu:latest

# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y && apt-get install python3 -y && apt-get install python3-pip -y

WORKDIR /app
COPY app /app
RUN pip3 --no-cache-dir install -r requirements.txt
EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["main.py"]