FROM yfix/baseimage

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN echo "===> Adding Ansible..." \
	&& echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee /etc/apt/sources.list.d/ansible.list \
	&& echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/ansible.list \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7BB9C367 \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y update \
	&& apt-get install -y \
		ansible \
		ssh
	\
	&& echo "===> Cleanup..." \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d/ansible.list

ADD ./docker /
ADD ./ansible/machine.py /machine.py
ADD ./ansible/playbooks /playbooks
ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/playbooks/bootstrap.yml"]
