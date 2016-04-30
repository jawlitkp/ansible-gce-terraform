FROM gliderlabs/alpine

MAINTAINER maratoid@gmail.com

RUN apk add --update git
RUN apk add --update python-dev py-pip gcc py-crypto
RUN pip install --upgrade pip && pip install git+https://github.com/evilkost/brukva.git && pip install tornado==3.2.2
RUN rm -rf /var/cache/apk/* && rm -Rf ~/.pip/cache/
RUN git clone https://github.com/maratoid/Tornado-Redis-Chat.git /tornadochat
EXPOSE 80
ENTRYPOINT ["/usr/bin/python", "/tornadochat/app.py", "--port=80"]