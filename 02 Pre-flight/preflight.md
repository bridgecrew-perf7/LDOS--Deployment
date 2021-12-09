## <font color='red'>Ansible-Centos7</font>
Ansible playbook configures the Nodes for Kubespray 2.14

Prerequisites for the CentOS7 machines:
* A public key generated on your Ansible Controller
* SSH passwordless access on Nodes with root permissions

The following playbooks are run:  

#### pre-flight_hardware.yml
* Update packages
* Install common packages
* Disable SELinux
* Disable SWAP
* Turn off firewall
* Set hostname
* Reboot Nodes

#### extra-vars.yml
* Configure the env.properties with required values
* Run the apply_env_properties.sh
* Check the extra-vars.yml values

#### download_kubespray.yml
* 
---

<em>Run the playbook - pre-flight_hardware.yml</em>  
This will update, install and configure the various required packages.

``run the playbook - pre-flight_hardware.yml:``
```
cd /etc/ansible/playbooks
ansible-playbook pre-flight_hardware.yml
```
Note the required vars:  
- ansible_ssh_private_key_file: "~/.ssh/id_rsa"  
- ansible_ssh_private_key_file_name: "id_rsa"  
- ansible_user: k8s  
- change_dns: true  
- dns_server: 10.0.0.254  <font color='green'> # SkyTap DNS </font> 
- ansible_python_interpreter: /usr/bin/python  

---

<em>Define the playbook - extra-vars.yml</em>   
<font color='red'>** This section has already been completed**</font>    
Kubespray has a bunch a defualt values that need to be replaced by the required values defined a s placeholders in the env.properties file.  

open env.properties file:
open extra-vars-template.yml
open apply_env_prperties.sh
open extra-vars.yml 

``edit the file and enter the following values:``
```
installer_node_hostname=installer.skytap.example
installer_node_ip=10.0.0.99
cluster_node_hostname=pentaho-server-1.skytap.example
cluster_node_ip=10.0.0.1
pem_file_name=id_rsa
ansible_user=k8s
```
``to define the extra-vars.yml, execute:``
```
./apply_env_properties.sh
```
``check extra-vars.yml``

---

<em>Run the playbook - download_kubespray.yml</em> 
Kubernetes clusters can be created using various automation tools. Kubespray is a composition of Ansible playbooks, inventory, provisioning tools, and domain knowledge for generic OS/Kubernetes clusters configuration management tasks. 

Kubespray provides:
* a highly available cluster
* composable attributes
* support for most popular Linux distributions

There is a sample inventory in the inventory folder. You need to copy that and name your whole cluster (e.g. mycluster). The repository has already provided you the inventory builder to update the Ansible inventory file.  

``copy inventory/sample as inventory/mycluster:``
```
cd Dow  Downloads/Kubespray/kubespray-release-2.14/inventory
sudo mkdir mycluster
cd ..
sudo cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(10.0.0.101 10.0.0.102 10.0.0.103)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
``check inventory/mycluster/hosts.yaml``

---

<em>Run the playbook - kubespray-release-2.14/cluster.yml</em>   
Its is important that you explicitly include all the parameters when running the kubespray-release-2.14/cluster.yml playbook. 
Kubespray release 2.14 installs and configures the Foundry Platform supported version: kubernetes 1.18.10

Pre-requistes:
* Firewalls are not managed by kubespray. You'll need to implement appropriate rules as needed. You should disable your firewall in order to avoid any issues during deployment.  
* If kubespray is ran from a non-root user account, correct privilege escalation method should be configured in the target servers and the ansible_become flag or command parameters --become or -b should be specified. 

``run the cluster.yml playbook:``
```
cd Downloads/Kubespray/kubespray-release-2.14
ansible-playbook -i hosts-skytap.yml --extra-vars "@extra-vars.yml"  -b cluster.yml  -t info
```
Note: 
---