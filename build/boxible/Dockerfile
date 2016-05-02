FROM gliderlabs/alpine

MAINTAINER maratoid@gmail.com

RUN apk add --update python-dev openssl-dev py-pip gcc py-crypto openssh
RUN pip install --upgrade pip && pip install paramiko==1.7.0 && pip install ansible==2.0.0.2
RUN rm -rf /var/cache/apk/* && rm -Rf ~/.pip/cache/
RUN mkdir /etc/ansible-control-path

ENV ANSIBLE_CONFIG=/etc/ansible/ansible.cfg
COPY ansible.cfg $ANSIBLE_CONFIG
VOLUME /etc/ansible-control-path