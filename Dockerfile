FROM ubuntu:noble AS base
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
RUN useradd -m -s /bin/bash kdlocpanda && echo 'kdlocpanda ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/kdlocpanda

COPY . . 


USER root

RUN chown -R kdlocpanda:kdlocpanda /home/kdlocpanda

USER kdlocpanda




#RUN ansible-pull -U https://github.com/joshyorko/ansible.git --vault-password-file password.txt

ENTRYPOINT ["/bin/bash"]
CMD ["-i"]
