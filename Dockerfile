FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update \
  && apt-get -y --no-install-recommends install \
    openssh-server \
    python3 \
    pwgen \
    sudo \
  && mkdir -p /var/run/sshd \
  && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY set_root_pw.sh /set_root_pw.sh
COPY run.sh /run.sh

RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
