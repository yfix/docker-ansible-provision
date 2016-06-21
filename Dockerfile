FROM debian:jessie

RUN apt-get update && \
    apt-get install -y ansible ssh && \
    rm -rf /var/lib/apt/lists/*

ADD ./docker /
ADD ./ansible/machine.py /machine.py
ADD ./ansible/playbooks /playbooks
ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/playbooks/bootstrap.yml"]
