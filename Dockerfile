FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install neovim bind9 dnsutils
WORKDIR /etc/bind
ADD named.conf.options .
ADD named.conf.local .
ADD test.home.zone /var/cache/bind/
RUN tsig-keygen -a HMAC-SHA256 tsig-key > ddns.key
RUN mkdir -p /etc/bind && chown root:bind /etc/bind/ && chmod 755 /etc/bind
RUN mkdir -p /var/cache/bind && chown bind:bind /var/cache/bind && chmod 755 /var/cache/bind
RUN mkdir -p /var/lib/bind && chown bind:bind /var/lib/bind && chmod 755 /var/lib/bind
RUN mkdir -p /var/log/bind && chown bind:bind /var/log/bind && chmod 755 /var/log/bind
RUN mkdir -p /run/named && chown bind:bind /run/named && chmod 755 /run/named
EXPOSE 53/udp 53/tcp 953/tcp
ENTRYPOINT ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
