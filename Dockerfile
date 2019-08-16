FROM nginx:latest

RUN apt-get install apt-transport-https

RUN apt-get update && apt-get -y install apt-utils gnupg2 curl

RUN echo "deb https://deb.torproject.org/torproject.org buster main" >> /etc/apt/sources.list && \
    echo "deb-src https://deb.torproject.org/torproject.org buster main" >> /etc/apt/sources.list && \
    curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
    apt-get update && apt-get -y install tor deb.torproject.org-keyring

COPY torrc /etc/tor/torrc

COPY default.conf /root/default.conf

COPY run.sh /root/run.sh

ENTRYPOINT ["/bin/sh", "/root/run.sh"]

CMD ["tor"]