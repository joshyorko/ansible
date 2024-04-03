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
RUN addgroup --gid 1000 jyorko
RUN adduser --gecos jyorko --uid 1000 --gid 1000 --disabled-password jyorko
RUN echo 'jyorko ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# New commands to create and set permissions for .ssh directory
RUN mkdir -p /home/jyorko/.ssh && \
    chown -R jyorko:jyorko /home/jyorko/.ssh

USER jyorko
WORKDIR /home/jyorko



# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
