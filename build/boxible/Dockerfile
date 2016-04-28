FROM gliderlabs/alpine

MAINTAINER maratoid@gmail.com

RUN apk add --update python-dev py-pip gcc py-crypto
RUN pip install --upgrade pip && pip install ansible
RUN rm -rf /var/cache/apk/* && rm -Rf ~/.pip/cache/
RUN mkdir /etc/ansible-control-path

ENV ANSIBLE_CONFIG=/etc/ansible/ansible.cfg
COPY ansible.cfg $ANSIBLE_CONFIG
VOLUME /etc/ansible-control-path