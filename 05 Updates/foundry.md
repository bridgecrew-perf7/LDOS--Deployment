## <font color='red'>Hitachi Vantara Foundry 2.2.1 Platform</font>
Ansible playbook installs and configures Hitachi Vantara Foundry Soluti

Prerequisites for the CentOS7 machines:
* A public key generated on your Ansible Controller
* SSH passwordless access on Nodes with root permissions
* Completed 01 Infrastructure section

This playbook will:
* Update packages
* Ensure Map Max count > 262144
* Install Helm - all Nodes
* Prepare kubeconfig
* Install jq
* Install kubectl
* Configure kubectl for 'installer' access
* Install Docker
* Configure a Docker insecure Registry - Ansible Controller
* Copy over certs to 'installer'
* Install OpenEBS storage class

---

<em>Run the playbook - pre-flight_foundry.yml</em>  
This will update, install and configure the various required packages.



run the playbook - pre-flight_foundry.yml: 
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" --become pre-flight_foundry.yml
```
Note the required vars:  
    ansible_ssh_private_key_file: "~/.ssh/id_rsa"  
    ansible_ssh_private_key_file_name: "id_rsa"  
    ansible_user: k8s  
    change_dns: true  
    dns_server: 10.0.0.254 <font color='green'># SkyTap DNS</font>  
    ansible_python_interpreter: /usr/bin/python

---