## <font color='red'>Configure Ansible</font>
Ansible is an open source IT Configuration Management, Deployment & Orchestration tool. It aims to provide large productivity gains to a wide variety of automation challenges. This tool is very simple to use yet powerful enough to automate complex multi-tier IT application environments. 


In this lab we're going to:
* configure ansible Controller
* configure ansible Nodes

* create SSH-keys

---

#### <font color='red'>Ansible Controller Configuration</font>
* create / select the account for ansible controller + all other Nodes
* ensure 'user' has root priviledges

* generate ssh keys

* update inventory file with the Node IPs 

</br>

**generate ssh keys**    
ensure your in home directory for the 'user' account.     
next create keys:  
```
cd
ssh-keygen
```
just hit enter...  
check ssh key:
```
ls -al
```
Note: now have a .ssh  
change directory to .ssh
```
cd .ssh
ls -lrt
```
Note: you know have 2 keys: id_rsa (private) id_rsa.pub (public)

</br>

if you wish to include localhost in your list of managed Nodes:  
remove authorized keys:
```
cd  .ssh/
ls -l
rm -rf authorized_keys
```
connect to localhost:
```
ssh localhost
```
copy key
```
ssh-copy-id localhost
```

</br>

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
check the inventory hosts file has been modified:
```
cat hosts | head -20
```
check connectivity:
```
ansible all -m ping
```
look for ping pong..  & check for python ..  should be 2.7 for the moment.

for a specfic node(s):
```
ansible 10.0.0.2 -m ping
```


---