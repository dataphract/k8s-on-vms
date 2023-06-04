#!/usr/bin/env bash

set -euf -o pipefail

ETCD_VERSION=v3.4.26
ARCHIVE_NAME="etcd-${ETCD_VERSION}-linux-amd64.tar.gz"

curl -L "https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/${ARCHIVE_NAME}" -o "/tmp/${ARCHIVE_NAME}"
mkdir -p "/tmp/etcd"
tar xzvf "/tmp/${ARCHIVE_NAME}" -C "/tmp/etcd" --strip-components=1
rm -f "/tmp/${ARCHIVE_NAME}"

cp "/tmp/etcd/etcd" "/usr/bin/etcd"
cp "/tmp/etcd/etcdctl" "/usr/bin/etcdctl"

which etcd
which etcdctl
