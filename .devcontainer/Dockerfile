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
RUN addgroup --gid 1000 cnoel
RUN adduser --gecos cnoel --uid 1000 --gid 1000 --disabled-password cnoel
RUN echo 'cnoel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# New commands to create and set permissions for .ssh directory
RUN mkdir -p /home/cnoel/.ssh && \
    chown -R cnoel:cnoel /home/cnoel/.ssh

USER cnoel
WORKDIR /home/cnoel



# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
