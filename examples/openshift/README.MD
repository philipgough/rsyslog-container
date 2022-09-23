#### Deploying on OpenShift

> **Note** 
> In later versions of OpenShift 3 (3.11+) you can deploy the router with logging enabled via a sidecar.
> To do so, run `oc adm router eg-router --extended-logging`.

> **Note**
> In later versions of OpenShift 4 (4.5+) logging can be configured directly on the IngressController.
> To do so, check out the [docs](https://docs.openshift.com/container-platform/4.11/networking/ingress-operator.html#nw-configure-ingress-access-logging_configuring-ingress).

-----------------

The following example shows how this image can be used to debug and get access logs for the HAProxy router running on OpenShift.

* Create the application in the `default` project. Wait for the Pod to enter a running state. The default service port is 514.

```
oc -n default new-app -f template.json
```

* Next, add the required environment variables to the router deployment which triggers a redeployment.
```
oc -n default env dc/router ROUTER_SYSLOG_ADDRESS=rsyslog ROUTER_LOG_LEVEL=debug
```

* At this point we should be able to read the HAProxy logs.

```
oc -n default logs -l logger=rsyslog
```
