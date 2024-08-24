#!/bin/sh

set -eux

_tmp="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
readonly curdir="$_tmp"
unset _tmp

readonly rabbitmq_version='3.13.6'
readonly rabbitmq_etc="$curdir/rabbitmq_server-$rabbitmq_version/etc/rabbitmq"
readonly rabbitmq_sbin="$curdir/rabbitmq_server-$rabbitmq_version/sbin"

if [ ! -d "$curdir/rabbitmq_server-$rabbitmq_version" ]
then
    curl -LO "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$rabbitmq_version/rabbitmq-server-generic-unix-$rabbitmq_version.tar.xz"
    tar xf "rabbitmq-server-generic-unix-$rabbitmq_version.tar.xz"
fi

cp -vf "$curdir/rabbitmq-env.conf" "$rabbitmq_etc/rabbitmq-env.conf"

RABBITMQ_ALLOW_INPUT='true' LOG='debug' "$rabbitmq_sbin/rabbitmq-server"
