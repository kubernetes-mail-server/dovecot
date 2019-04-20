FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN set -x && apt-get update \
    && apt-get --no-install-recommends install -y \
        gnupg lsb-release curl ca-certificates netcat \
        dovecot-core dovecot-mysql dovecot-submissiond \
        dovecot-imapd dovecot-pop3d dovecot-lmtpd \
    && echo "disable rspam installation for now"

# Remove the existing folders and create empty folders
RUN rm -rf /etc/dovecot
RUN rm -rf /var/lib/dovecot && mkdir /var/lib/dovecot

COPY config /etc/dovecot

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Unencrypted and encrypted pop
EXPOSE 110/tcp 995/tcp

# Uncrypted and encrypted imap
EXPOSE 143/tcp 993/tcp

# Email Submission port
EXPOSE 587/tcp

# LMTP port
EXPOSE 24/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/dovecot", "-c", "/etc/dovecot/dovecot.conf", "-F"]
