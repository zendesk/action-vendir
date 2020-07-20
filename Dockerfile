# Container image that runs your code
FROM  ubuntu:focal
RUN apt update -y && apt upgrade -y && \
  apt install git -y

COPY vendir-linux-amd64* /usr/local/bin/vendir
RUN chmod +x /usr/local/bin/vendir

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["/entrypoint.sh"]
