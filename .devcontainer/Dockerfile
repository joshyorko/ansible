FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential \
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install ansible --yes \
    && apt-get clean autoclean && \
    apt-get autoremove --yes 


FROM base AS yorko
ARG TAGS
RUN addgroup --gid 1000 kdlocpanda
RUN adduser --gecos kdlocpanda --uid 1000 --gid 1000 --disabled-password kdlocpanda
RUN echo 'kdlocpanda ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# New commands to create and set permissions for .ssh directory
RUN mkdir -p /home/kdlocpanda/.ssh && \
    chown -R kdlocpanda:kdlocpanda /home/kdlocpanda/.ssh

USER kdlocpanda
WORKDIR /home/kdlocpanda



# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
