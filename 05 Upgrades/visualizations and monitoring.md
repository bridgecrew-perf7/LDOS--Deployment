## <font color='red'>Visualize and Monitoring your Mesh</font>
The following 
* Kiali
* Prometheus
* Grafana
* Elasticsearch
* Kibana
* Jaeger

To display a list of exposed services in the istio-system:

``list of istio services (Ansible Controller):``
```
kgsvc -n istio-system
```
Note the ports.
---

#### <font color='red'>Kiali</font>
Kiali is an observability console for Istio with service mesh configuration and validation capabilities.It helps you understand the structure and health of your service mesh by monitoring traffic flow to infer the topology and report errors. Kiali provides detailed metrics and a basic Grafana integration, which can be used for advanced queries. Distributed tracing is provided by integration with Jaeger.

``check Kiali service:``
```
kubectl -n istio-system get svc kiali
```
``to access the Kiali UI:``
```
istioctl dashboard kiali
```
``using kubectl to port-forward:``
```
kubectl port-forward svc/kiali 20001:20001 -n istio-system
```
> browse to: https://localhost:20001/ 

User: admin
Password: admin

Please note that this method exposes Kiali only to the local machine, no external users. You must have the necessary privileges to perform port forwarding.

* You can visualize the services and their connections in a given namespace by clicking on the “Go To Graph” button.

For further details: > https://kiali.io/docs/

---

#### <font color='red'>Prometheus</font>
Prometheus is an open-source systems monitoring and alerting toolkit. Prometheus collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

``check Prometheus service:``
````
kubectl -n istio-system get svc prometheus
````
``using kubectl to port-forward:``
```
kubectl port-forward svc/prometheus 9090:9090 -n istio-system
```
> browse to: https://localhost:9090

* navigate to: Status --> Targets

For further details: > 

---

#### <font color='red'>Grafana</font>
Grafana is an open source solution for running data analytics, pulling up metrics that make sense of the massive amount of data & to monitor our apps with customizable dashboards.  
Grafana connects with every possible data source, commonly referred to as databases such as Graphite, Prometheus, Influx DB, ElasticSearch, MySQL, PostgreSQL etc.

``check Grafana service:``
````
kubectl -n istio-system get svc grafana
````


For further details: > https://grafana.com/