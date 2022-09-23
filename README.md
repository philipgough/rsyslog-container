# rsyslog-container

A lightweight, UBI 8 based [rsyslog](http://www.rsyslog.com) image which logs to stdout.

### Why does this exist?

This was originally created to debug and get access logs from a custom HAProxy router running on early
versions of OpenShift which required a syslog endpoint.

The example for that use case is described [here](./examples/openshift/README.MD).

This predated the [official images](https://github.com/rsyslog/rsyslog-docker) for rsyslog.

It is being kept alive because it has several thousand pulls on Docker Hub and is still being pulled daily.
Perhaps someone found an alternative use case for it, but it was never intended for production :)
