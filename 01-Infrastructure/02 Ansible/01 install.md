## <font color='red'>Installation of Ansible</font>
Ansible is an open source IT Configuration Management, Deployment & Orchestration tool. It aims to provide large productivity gains to a wide variety of automation challenges. This tool is very simple to use yet powerful enough to automate complex multi-tier IT application environments. 

In this lab we're going to:
* Install ansible controller

#### If you're new to Ansible you may want to take the course: LDS3013S - Introduction to Ansible.


---

#### <font color='red'>Pre-requisties</font> 
Please ensure that the Environment has been configured as outlined in the previous section - 01-Environment:
* installer user added - with sudo & passwordless privileges
* openssh server & client - check ssh
* pip & pip3
*  

apply updates:
```
sudo apt update
sudo apt upgrade -y
sudo reboot
```


---


#### <font color='red'>Install Ansible</font> 
This installs Ansible on Ubuntu 20.04
install ansible:
```
sudo apt install -y ansible
```
verify the installation:

ansible --version



**SSH**  
check if SSH is running:
```
ps aux | grep sshd
```
check if listening on port 22:
```
netstat -plant | grep :22
```
or check service:
```
sudo systemctl status sshd
```
</br>

**Ansible Nodes**  
ensure you have the following information:
* Ansible Node IP address - 10.0.0.2 & 10.0.0.3
* Account credentials to SSH
  - user: centos  
  - password: centos  
* Python 2.7+ / 3.5+ is installed on Node(s)

---

#### <font color='red'>Install Ansible Controller</font>
The next step is to install Ansible controller: 

ensure you're root:
```
sudo -i
```
install Ansible :
```
yum install ansible
```
Note: you will get a keyboard error if you have set Python 3.5+ as default. Switch back to Python 2 - see section 'Python 3' 
(alternatives --config python)

verify ansible:
```
ansible --version
```
Note: the path to ansible.cfg  path to python & python version..  

browse ansible directory:
```
cd   /etc/ansible
ls -lrt
```
Note: these are the configuration files.
* roles
* hosts
* ansible.cfg

  > for further information: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#


clean up:
```
sudo yum remove ansible -y
```

---