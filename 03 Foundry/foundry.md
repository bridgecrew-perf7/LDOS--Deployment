## <font color='red'>Ansible-Centos7</font>
Ansible playbook configures the Nodes for Kubespray 2.14

Prerequisites for the CentOS7 machines:
* SSH access using password with a user who has root permissions
* A public key generated on your Ansible Controller

This playbook will:
* Update packages
* Install common packages
* Disable SELinux
* Disable SWAP
* Turn off firewall
* Set hostname
* Reboot Nodes

---

<em>Run the playbook - pre-flight.yml</em>  
This will update, install and configure the various required packages.

check you can ssh into the Nodes:
```
ssh k8s@10.0.0.2
ssh k8s@10.0.0.3
ssh k8s@10.0.0.4
```
Note: k8s passwordless authenticated connection.

run the playbook - pre-flight.yml: 
```
cd /etc/ansibe/playbooks
ansible-playbook pre-flight.yml
```
Note the required vars:
    ansible_ssh_private_key_file: "~/.ssh/id_rsa"
    ansible_ssh_private_key_file_name: "id_rsa"
    ansible_user: k8s
    change_dns: true
    dns_server: 10.0.0.254 # SkyTap DNS
    ansible_python_interpreter: /usr/bin/python

---