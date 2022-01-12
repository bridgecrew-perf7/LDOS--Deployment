## <font color='red'>Lumada DataOps Suite 1.1.1</font>
DataOps unlocks business value by operationalizing data management with automation and collaboration. Lumada DataOps Suite helps you build your DataOps practice for more business agility with an intelligent data operations platform.

#### <font color='red'>Prerequisites for LDOS:</font>
* Foundry Platform:   
LDOS is installed over an existing k8s cluster running cluster services (a default storage class, istio and  cert-manager) and the Hitachi Vantara Solution Control Plane.  

* Metrics-addon: 


* NFS Server:   
The Dataflow engine needs access to the Pentaho ETL files, plug-ins and kettle.properties. These will be mounted, into the containers, via NFS from an external NFS Server mount point. 

* Object Storage Service: 
 The Catalog leverages an object store to manage it's fingerprinting and Spark logs.  The default internal minio pod is not sufficient to handle production workloads (as it will fill up the clusters filesystem).   A thrid party object store, such as S3 or an external mino cluster should be used in production installations.

  - The LDOS installation requires configuraiton for the local environment.  Many of these are already set/used to install the control-plane.   Others can be discovered from the cluster.
    - The NFS mount point needs to be specified in the extra-vars.yml.  If it is missing the pods will fail to attach to it at startup and the install process will not complete.
    - The Object Store needs to be configured at install.   The default configuration for minio can be used and then changed after install, or the HELM chart for catalog can be modified prior to installation.
    - The default installation is: LDOS.  To change this, manually edit the "install_mode" in env.properties.
    - Additional editing of the default helm charts or install.sh itself may be needed for a custom installation of the product components.

Please read the documentation: [LDOS 1.1.1 Installation & Configuration](resources/LDOS-1.1.1_Installation_and_Configuration_Guide.pdf)    

#### <font color='red'>Downloads</font>
All files required for installation are available in the release folder and can be found in the link below.
https://hcpanywhere.hitachivantara.com/a/PWPVYtZj1UovY9VO/e52a0db2-ad14-4673-941b-c304c2b108b2?l

You’ll need your Hitachi Vantara credentials or ask Customer Success.

#### <font color='red'>Kubernetes Management</font>
To properly access the kubernetes cluster, you need to configure your kubeconfig.
The default location:  
``~/.kube/config ``

#### <font color='red'>Access the Solution management UI</font>
In order to access the Solution management UI, you need to get the password for the admin user foundry. 
```
# get password for foundry user:
echo $(kubectl get keycloakusers -n hitachi-solutions keycloak-user -o 
jsonpath='{.spec.user.credentials[0].value}')
```
Keep this password for later.


---


<em>Check Foundry Platform</em>
Before you start the LDOS installation, check that the Foundry Platform is healthy.

``check nodes (from the Ansible Controller box):``
```
kubectl get nodes -o wide (alias: kgn -o wide)
```
``check pods:``
```
kubectl get pods -o wide
```

<em>Download and unpack the Metrics Add-On</em>