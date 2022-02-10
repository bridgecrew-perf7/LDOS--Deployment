## <font color='red'>Visualize and Monitoring your Mesh</font>  

The following services are exposed in the Foundry Platform. 
* Kiali
* Prometheus
* Grafana
* Elasticsearch & Kibana
* Jaeger
* Swagger

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
Note: its exposed on the default port: 20001
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
kubectl port-forward -n istio-system  svc/prometheus 9090:9090 
```
> browse to: https://localhost:9090

* navigate to: Status --> Targets

For further details: > 

---

#### <font color='red'>Grafana</font>  

Grafana is an open source solution for running data analytics, pulling up metrics that make sense of the massive amount of data & to monitor our apps with customizable dashboards.  
Grafana connects with every possible data source, commonly referred to as databases such as Graphite, Prometheus, Influx DB, ElasticSearch, MySQL, PostgreSQL etc.

``check Grafana service:``
```
kubectl -n hitachi-solutions get svc
```
Note: look for anything grafana

> browse to: https://pentaho-server-1.skytap.example/hitachi-solutions/metrics-addon-solution/metrics-addon-solution-grafana/login

User: admin
Password: mypassword

``to retrieve the password:``
```
kubectl get secret -n hitachi-solutions metrics-addon-solution-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

> For further details: https://grafana.com/

---

#### <font color='red'>Elasticsearch & Kibana</font>

Elasticsearch is the distributed search and analytics engine at the heart of the Elastic Stack. Logstash and Beats facilitate collecting, aggregating, and enriching your data and storing it in Elasticsearch. Kibana enables you to interactively explore, visualize, and share insights into your data and manage and monitor the stack. Elasticsearch is where the indexing, search, and analysis happens.

Kibana is a visual interface tool that allows you to explore, visualize, and build a dashboard over the log data massed in Elasticsearch Clusters.

``check Kibana service:``
```
kubectl -n hitachi-solutions get svc
```
Note: look for anything kibana

> browse to: https://pentaho-server-1.skytap.example/hitachi-solutions/hscp-hitachi-solutions/kibana/app/kibana

You will need to 'Discover' your data and enter an 'Index pattern': ``hitachi-solutions.*`` 

For further details: > https://www.elastic.co/kibana/

---

#### <font color='red'>Jaeger</font>  

The Jaeger tracing system is an open-source tracing system for microservices, and it supports the OpenTracing standard.
``check Kiali service:``
```
kubectl -n istio-system get svc jaeger-query
```
Note: its exposed on the default port: 16686
``using kubectl to port-forward:``
```
kubectl port-forward -n istio-system svc/jaeger-query 16686:16686
```

> browse to: https://localhost:9090/jaeger/search

For further details: > https://www.jaegertracing.io/

---

#### <font color='red'>Swagger</font>  

The Swagger Editor is an open source editor to design, define and document RESTful APIs in the Swagger Specification. The source code for the Swagger Editor can be found in GitHub.

> browse to: https://pentaho-server-1.skytap.example/hitachi-solutions/hscp-hitachi-solutions/swagger-ui/ui/doc/


For further details: > https://github.com/swagger-api/swagger-editor

---