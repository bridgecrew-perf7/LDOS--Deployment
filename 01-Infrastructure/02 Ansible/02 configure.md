## <font color='red'>Configure Ansible</font>
Ansible is an open source IT Configuration Management, Deployment & Orchestration tool. It aims to provide large productivity gains to a wide variety of automation challenges. This tool is very simple to use yet powerful enough to automate complex multi-tier IT application environments. 


In this lab we're going to:
* configure ansible Controller
* configure ansible Nodes

* update Inventory hosts

---

#### <font color='red'>Ansible Controller Configuration</font>

* create / select the account for ansible controller
* ensure 'installer' has root priviledges

* generate ssh keys

* update inventory file with the Node IPs 


**update Inventory file**  
ensure that you're logged with ansadmin credentials, on Ansible Controller.  
change directory:
```
cd /etc/ansible
ls -al
```
edit the hosts file:
```
sudo nano hosts
```
add the node IPs:
```
[all]
node1 ansible_host=10.0.0.2
node2 ansible_host=10.0.0.3
node3 ansible_host=10.0.0.4
```
and save..  
Ctrl o
Return 
Ctrl x

</br>

**set host_key_checking**   
you will need to disable SSH key host checking.

edit the ansible.cfg file:
```
sudo nano ansible.cfg
```
uncomment the line (71): host_key_checking = False


---