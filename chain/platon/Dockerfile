FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y wget

RUN mkdir -p ~/platon-node/data
RUN wget https://download.platon.network/platon/platon/1.0.0/platon -P /usr/bin && \
    wget https://download.platon.network/platon/platon/1.0.0/platonkey -P /usr/bin && \
    chmod +x /usr/bin/platon /usr/bin/platonkey

ENTRYPOINT ["/bin/sh", "-c", "startup.sh"]
