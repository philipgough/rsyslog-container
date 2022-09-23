FROM redhat/ubi8-minimal:8.6

RUN  microdnf -y install rsyslog && \
	 microdnf clean all && \
     rm -rf /var/cache/yum

RUN chgrp -R 0 /var/lib/rsyslog && \
    chmod -R g+rwX /var/lib/rsyslog && \
    chgrp -R 0 /var/log && \
    chmod -R g+rwX /var/log

COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 1514
USER 1001
CMD ["sh", "-c", "/usr/sbin/rsyslogd -i /tmp/rsyslog.pid -n -f /etc/rsyslog.conf"]

