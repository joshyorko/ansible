FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes 

FROM base AS yorko
ARG TAGS
RUN addgroup --gid 1000 jyorko
RUN adduser --gecos jyorko --uid 1000 --gid 1000 --disabled-password jyorko
RUN echo 'jyorko ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/jyorko

COPY . .


USER root

RUN chown -R jyorko:jyorko /home/jyorko

USER jyorko




#RUN ansible-pull -U https://github.com/joshyorko/ansible.git --vault-password-file password.txt

ENTRYPOINT ["/bin/bash"]
CMD ["-i"]
