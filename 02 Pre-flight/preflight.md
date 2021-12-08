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

run the playbook - pre-flight_hardware.yml: 
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

edit the file and enter the following values:
```
installer_node_hostname=installer.skytap.example
installer_node_ip=10.0.0.99
cluster_node_hostname=pentaho-server-1.skytap.example
cluster_node_ip=10.0.0.1
pem_file_name=id_rsa
ansible_user=k8s
```
to define the extra-vars.yml, execute:
```
./apply_env_properties.sh
```
check extra-vars.yml

---

<em>Run the playbook - download_kubespray.yml</em> 
Kubespray 

---