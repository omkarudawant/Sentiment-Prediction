FROM alpine:3.7

RUN apt update && apt install -y python3 python3-pip sudo
RUN useradd -m omkar
RUN chown -R omkar:omkar /home/omkar/
COPY --chown=omkar . /home/omkar/

USER omkar

RUN pip3 install --upgrade pip

RUN cd /home/omkar/app/ && pip3 install pip3 install -r requirements.txt

WORKDIR /home/omkar/app

EXPOSE 8080

ENTRYPOINT python3 app.py