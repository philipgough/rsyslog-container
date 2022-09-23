#!/usr/bin/env bash

set -e -x -o pipefail

function cleanup {
  docker stop rsyslog-test
  kind delete cluster --name jsonnet-test
}

trap cleanup EXIT


function run() {
  build
  setup

  while ! timeout 1 bash -c "echo > /dev/tcp/localhost/1514"; do
    sleep 1
  done

  echo "This is a test" | nc -v -w 0 127.0.0.1 1514
  docker logs rsyslog-test | grep "This is a test"
  exit $?
}

function build() {
  make image TAG=latest
}

function setup() {
  docker run --name=rsyslog-test --rm -p 1514:1514 docker.io/philipgough/rsyslog:latest &
}

run
