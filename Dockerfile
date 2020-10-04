FROM ubuntu:18.04

RUN apt-get update && apt-get install -y python3 python3-pip sudo
RUN useradd -m omkar
RUN chown -R omkar:omkar /home/omkar/
COPY --chown=omkar . /home/omkar/app/

USER omkar

RUN pip3 install --upgrade pip

RUN cd /home/omkar/app/ && python3 -m pip install -r requirements.txt

WORKDIR /home/omkar/app

EXPOSE 8080

ENTRYPOINT python3 app.py
