## <font color='red'>Hitachi Vantara Foundry 2.2.1 Platform</font>
Ansible playbook installs and configures Hitachi Vantara Foundry Soluti

Prerequisites for the CentOS7 machines:
* A public key generated on your Ansible Controller
* SSH passwordless access on Nodes with root permissions
* Completed 01 Infrastructure section
* Completed 02 Pre-flight section

The following playbooks are run:  

#### pre-flight_foundry.yml
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


#### install_foundry.yml


---

<em>Run the playbook - pre-flight_foundry.yml</em>  
This will update, install and configure the various required packages.

Before you run the playbook ensure that 


run the playbook - pre-flight_foundry.yml: 
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" --become pre-flight_foundry.yml
```
Notice that the last few playbooks havent run.  To complete the playbook tasks:

``restart Docker:``
```
systemctl status docker
systemctl restart docker
```
Note: This is really just a check of the docker service

Configure Registry


---