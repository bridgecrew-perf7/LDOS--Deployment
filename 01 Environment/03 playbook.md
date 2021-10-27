## <font color='red'>Ansible-Centos7</font>

Ansible playbook to configure prerequisites for Kubespray on CentOS7

Prerequisites for the CentOS7 machines:
* SSH access using password with a user who has root permissions (centos in example)
* A public key generated on your local machine

This playbook will:
* Update packages
* Install network tools
* Install and configure ntpd
* disable firewall
* disable swap
* enable passwordless sudo
* enable passwordless SSH
* set hostname


```

Run the playbook. 
Define variables:
root user: centos
root password: centos
group: centos
path to public key: ~/.ssh/id_rsa.pub 

```
$ ansible-playbook -i hosts.ini -u centos -k playbook.yml --extra-vars "ansible_sudo_pass=centos  user=centos group=centos pubkeypath=~/.ssh/id_rsa.pub"
```

check you can ssh into the Nodes:
```
ssh 10.0.0.2
ssh 10.0.0.3
ssh 10.0.0.4
```
Note: passwordless authenticated connection.

---