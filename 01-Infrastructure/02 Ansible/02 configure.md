## <font color='red'>Configure Ansible</font>
Ansible is an open source IT Configuration Management, Deployment & Orchestration tool. It aims to provide large productivity gains to a wide variety of automation challenges. This tool is very simple to use yet powerful enough to automate complex multi-tier IT application environments. 


In this lab we're going to:
* configure ansible Controller
* configure ansible Nodes

* update Inventory hosts
* add workshop directories
---

#### <font color='red'>Ansible Controller Configuration</font>
Ensure that the required pre-requisites have been completed as outlined in the previous section - 01-Infrastructure.
* create 'installer' account for ansible controller
* ensure 'installer' has root priviledges

* generate ssh keys

* update inventory file with the Node IPs 

---

<em>Update Hosts - Inventory</em>  
In this first part we will edit the default hosts to include our Cluster Nodes.  

change directory:
```
cd /etc/ansible
ls -al
```
edit the hosts file:
```
sudo nano hosts
```
add the Node IPs:
```
[all]
10.0.0.101
10.0.0.102
10.0.0.103
```
and save..  
Ctrl o
Return 
Ctrl x

Note: 

---

<em>edit the ansible.cfg</em>
Apply the following configuration changes:    

edit the ansible.cfg file:
```
sudo nano ansible.cfg
```
uncomment the line (14): inventory = /etc/ansible/hosts
uncomment the line (68): roles_path = /etc/ansible/roles
uncomment the line (71): host_key_checking = False
uncomment the line (103): timeout=180
uncomment the line (375): ssh_args = -C -o ControlMaster=auto -o ControlPersist=30m
uncomment the line (401): pipelining = False  (disable requiretty in /etc/sudoers)

---

<em>add directories</em>
create the following directories:
```
cd
cd /etc/ansible
sudo mkdir roles
sudo mkdir playbooks
```

---