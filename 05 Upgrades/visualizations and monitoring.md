## <font color='red'>Visualize and Monitoring your Mesh</font>
Lumada DataOps Suite 1.2.0 includes a newer version of the following solutions:
* Kiali
* Prometheus
* Grafana
* Elasticsearch
* Kibana
* Jaeger

---

#### <font color='red'>Kiali</font>


``verify the service is running in your cluster:``
```
kubectl -n istio-system get svc kiali
```

``to access the Kiali UI:``
```
istioctl dashboard kiali
```

If you have kubectl command line tool

kubectl port-forward svc/kiali 20001:20001 -n istio-system

Note: These commands will block. Access Kiali by visiting https://localhost:20001/ in your preferred web browser.

Please note that this method exposes Kiali only to the local machine, no external users. You must have the necessary privileges to perform port forwarding.

---

<em>Run the playbook - upgrade_ldos.yml</em>  
This will upgrade and configure the various required packages.
``run the playbook - upgrade_ldos.yml:``
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" -b -v upgrade_ldos.yml
```



---
