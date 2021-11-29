## <font color='red'>Ansible-Centos7</font>
Ansible playbook configures the Nodes for Kubespray 2.14

Prerequisites for the CentOS7 machines:
* SSH access using password with a user who has root permissions
* A public key generated on your Ansible Controller

This playbook will:
* Update packages
* Install network tools
* Install and configure ntpd
* Disable firewall
* Disable swap
* Enable passwordless sudo
* Enable passwordless SSH
* Set hostname

Run the playbook. 
Define extra variables:
root user: centos
root password: centos
group: centos
path to public key: ~/.ssh/id_rsa.pub 

```
ansible-playbook -u centos -k /etc/ansible/playbooks/playbook.yml --extra-vars "ansible_sudo_pass=centos  user=centos group=centos pubkeypath=~/.ssh/id_rsa.pub"
```

check you can ssh into the Nodes:
```
ssh 10.0.0.2
ssh 10.0.0.3
ssh 10.0.0.4
```
Note: passwordless authenticated connection.

---