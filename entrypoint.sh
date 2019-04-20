#!/usr/bin/env bash

function required () {
    eval v="\$$1";

    if [ -z "$v" ]; then
        echo "$1 envvar is not configured, exiting..."
        exit 0;
    else
        [ ! -z "${ENTRYPOINT_DEBUG}" ] && echo "Rewriting required variable '$1' in file '$2'"
        sed -i "s~{{ $1 }}~$v~g" $2
    fi
}

function optional () {
    eval v="\$$1";

    [ ! -z "${ENTRYPOINT_DEBUG}" ] && echo "Rewriting optional variable '$1' in file '$2'"
    sed -i "s~{{ $1 }}~$v~g" $2
}

for file in $(find /etc/dovecot -type f); do
    required LOGGING_AUTH_VERBOSE ${file}
    required LOGGING_AUTH_VERBOSE_PASSWORDS ${file}
    required LOGGING_AUTH_DEBUG ${file}
    required LOGGING_AUTH_DEBUG_PASSWORDS ${file}
    required LOGGING_MAIL_DEBUG ${file}
    required LOGGING_VERBOSE_SSL ${file}

    required HAPROXY_TRUSTED_NETWORKS ${file}
    required HAPROXY_TIMEOUT ${file}
    required HAPROXY_IMAP ${file}
    required HAPROXY_IMAPS ${file}
    required HAPROXY_POP3 ${file}
    required HAPROXY_POP3S ${file}
    required HAPROXY_SUBMISSION ${file}
    required HAPROXY_LMTP ${file}

    required LMTP_PORT ${file}

    required POSTMASTER ${file}
    required SERVER_DOMAIN ${file}
    required SERVER_HOSTNAME ${file}
    optional RECIPIENT_DELIMITER ${file}

    required SUBMISSION_HOST ${file}
    required SUBMISSION_PORT ${file}
    required SUBMISSION_SSL ${file}
    required SUBMISSION_SSL_VERIFY ${file}

    required DATABASE_HOSTNAME ${file}
    required DATABASE_PORT ${file}
    required DATABASE_USERNAME ${file}
    required DATABASE_PASSWORD ${file}
    required DATABASE_NAME ${file}
done

echo "Running '$@'"
exec $@
