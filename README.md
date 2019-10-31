## rsyslog-container

A lightweight, Centos 7 based [rsyslog](http://www.rsyslog.com) image which logs to stdout. It can be used in a container-based environment (mainly for debugging purposes), where systemd and journald will likely not be running in containers. This allows us to view syslog entries using the `docker logs` command, or to be picked up by centralized logging tools.


#### Deploying on OpenShift

Note: In later versions of OpenShift (3.11+) you can deploy the router with logging enabled in a separate container within the router Pod.

To do so, run `oc adm router eg-router --extended-logging` and tail the logs from the syslog container.

-----------------

The following example shows how this image can be used to debug and get access logs for the HAProxy router running on OpenShift.

Pull down this repository, or copy the contents of `rsyslog-server-oscp-template.json` locally. This tempate will create a DeploymentConfig and Service for the `rsyslog-container` Pod. The default service port is 514.

* Login as the OpenShift administrator and create the application in the `default` project. Wait for the Pod to enter a running state.

```
oc login -u system:admin
oc new-app -f rsyslog-server-oscp-template.json -n default
oc get po -n default -w
```

* Next, add the required environment variables to the router project. This will trigger a re-deployment of the HAProxy router. Wait for it to run.
```
oc env dc/router ROUTER_SYSLOG_ADDRESS=rsyslog ROUTER_LOG_LEVEL=debug -n default
oc get po -n default -w
```

* At this point we should be able to via the HAProxy logs in the logs of the rsyslog Pod.

```
oc logs $(oc get po -n default | grep rsyslog | awk '{print $1}') -n default
```
