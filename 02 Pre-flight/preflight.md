## <font color='red'>Ansible-Centos7</font>
Ansible playbook configures the Nodes for Kubespray 2.14

Prerequisites for the CentOS7 machines:
* A public key generated on your Ansible Controller
* SSH passwordless access on Nodes with root permissions

This playbook will:
* Update packages
* Install common packages
* Disable SELinux
* Disable SWAP - also handled by Kubespray
* Turn off firewall - also handled by Kubespray
* Set hostname
* Reboot Nodes

check you can ssh into the Nodes:
```
ssh k8s@10.0.0.101
ssh k8s@10.0.0.102
ssh k8s@10.0.0.103
```
Note: k8s passwordless authenticated connection.

---

<em>Run the playbook - pre-flight_hardware.yml</em>  
This will update, install and configure the various required packages.

run the playbook - pre-flight_hardware.yml: 
```
cd /etc/ansibe/playbooks
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