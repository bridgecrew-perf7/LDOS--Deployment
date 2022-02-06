## <font color='red'>Lumada DataOps Suite 1.1.1</font>
DataOps unlocks business value by operationalizing data management with automation and collaboration. Lumada DataOps Suite helps you build your DataOps practice for more business agility with an intelligent data operations platform.

#### <font color='red'>Prerequisites for LDOS:</font>
* Foundry Platform:   
LDOS is installed over an existing k8s cluster running cluster services (a default storage class, istio and  cert-manager) and the Hitachi Vantara Solution Control Plane.  

* Metrics-addon: 
The Metrics Add-On is a generic extension for Foundry. It will be installed as a common solution in Foundry that will silently and transparently collect generic kubernetes metrics about any resource in the cluster.

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

All files required for installation are available in the release folder and can be found in the link below.
https://hcpanywhere.hitachivantara.com/a/PWPVYtZj1UovY9VO/e52a0db2-ad14-4673-941b-c304c2b108b2?l

You’ll need your Hitachi Vantara credentials or ask Customer Success.

The following playbooks are run:

#### preflight_nfs.yml
* Install NFS
* Create exports configuration file
* Start NFS
* Check NFS mounts
* Show mounts   

#### install_ldos.yml
* Install NFS utils
* Create directories
* Prepare env.properties
* Get foundry password
* Populate env.properties template
* Apply CRDs
* Update Hostnames in Helm Charts
* Install LDOS
* Check Pods

---

#### <font color='red'>Pre-requisties</font>

* Check the Health of the Foundry Platform
* Install Metrics-addon 1.0.0
* Install NFS Server

<em>Check Foundry Platform</em>  
Before you start the LDOS installation, check that the Foundry Platform is healthy.

``check namespaces (from the Ansible Controller box):``
```
kubectl get namespaces -o wide (alias: kgns -o wide)
```
``check nodes:``
```
kubectl get namespaces -o wide (alias: kgno -o wide)
```
``check Pods in hitachi-solutions:``
```
kubectl get pods -n hitachi-solutions -o wide (alias: kgpo -n hitachi-solutions -o wide)
```

---

<em>Download and unpack the Metrics Add-On (Optional)</em>  
If you have completed the Installation & Configuration of the Foundry Platform, the Metrics-addon 1.0.0. image and chart has been uploaded into the Registry.  

Recommended to let the LDOS install script install the Metrics-addon.

Please refer to: Lab - LDOS Pre-flight

Please refer to the documentation to manually upload: [LDOS 1.1.1 Installation & Configuration](resources/LDOS-1.1.1_Installation_and_Configuration_Guide.pdf)  


Please refer to the official Metrics Add-On documentation for details and additional troubleshooting: 
http://docs.foundry.wal.hds.com/addons/metricsaddon/docs/1.0.0/UserManuals/InstallingMetricsAddonSolutionAtControlPlane/


``verfify Metrics-addon CRDs:``
```
kubectl get CrdPackage -n foundry-crds | grep "metrics"
```
``verfify Metrics-addon:``
```
kubectl get solutionpackage -n hitachi-solutions | grep "metrics"
```

---

<em>Install NFS Server - preflight_nfs.yml</em>  
Installs a NFS server that is required by the DataFlow Engine and DataFlow Importer.

<font color='green'>The NFS server has been installed and configured.</font>

``run the playbook - pre-flight_nfs.yml:``
```
cd /etc/ansible/playbooks
ansible-playbook pre-flight_nfs.yml
```
The /etc/exports file controls which file systems are exported to remote hosts and specifies options.  
``verify the export configuration file (HA Proxy Server):``
```
sudo nano /etc/exports
```

---

#### <font color='red'>Install LDOS 1.1.1- install_ldos.yml</font>  
The install-ldos.yml playbook performs the following tasks.
- Install NFS utilities on all hosts. Again, this is needed to be able to mount the shared directory for KTR, KJB and additional content.
- Run update-hostname.sh to update the hostnames within the Helm chart templates.
- Run upload-solutions.sh to load the modified Helm charts into the Solution Control Plane, to make them available for installation.
- Configure env.properties values based on the local environment (see env.properties.template for additonal context)
    
    ####
    |Variable|Value|From|
    |-|-|-|
    | hostname|{{ apiserver_loadbalancer_domain_name }}|                            from extra-vars.yml|
    | registry|{{ master_node_for_registry }}:{{ master_node_for_registry_port }}|  from extra-vars.yml|
    | foundry_client_secret|{{ scp_client_secret }}    |                            extracted from the installation|
    | username|foundry                                 |                            hardcoded|
    | password|{{ foundry_password }}                  |                            extracted from the installation|
    | volume_host|{{ nfs_host }}                       |                            from extra-vars.yml|
    | volume_path|{{ nfs_path }}                       |                            from extra-vars.yml|


``run the playbook - install_ldos.yml:``
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" -b -v install_ldos-<version>.yml
```
Note: This will take about 30mins to complete.

``verfify solution packages:``
```
kubectl get solutionpackage -n hitachi-solutions
```

The script install the default users and roles. Please refer to documentation.

---

#### <font color='red'>Post-Installation Tasks</font>  

The following post-installation tasks need to be completed:
* Licenses for Lumada Data Integration
* License for Lumada Data Catalog

---

<em>Lumada Data Integration Licenses</em>  
The LDOS package doesn’t contain licenses.   
Please contact Customer Success or Product Management on how to get a license.  
The Data Transformation Editor and Dataflow Engine require a Pentaho EE license to run.   

ensure you are on the HA Proxy server.

``copy Pentaho EE license file (HA Proxy):`` 
 ```
 cd Dowmloads
 sudo cp -rfp *.lic /data/licenses/
```

---

<em>Lumada Data Catalog License</em>  

The Lumada Data Catalog is by default a light version (some functions are disabled).

``upgrade the Catalog license (Ansible Controller):``
```
kubectl create secret generic ldc-license --from-file=license-features.yaml --from-file=ldc-license-public-keystore.p12 -n hitachi-solutions
```
Note: Files must be named license-features.yaml and ldc-license-public-keystore.p12

Navigate to the Solution management UI -> Installed -> Lumada Data Catalog  
``add the following lines to values.yml:``

<pre><code>global:  
  coreSiteSecret: {}  
  ldc:                          <font color='green'> # line 4 </font>  
    licenseSecret: ldc-license  <font color='green'> # line 5 </font> </code></pre> 
 
 Click: Save and the Lumada Data Catalog will activate the license.

---