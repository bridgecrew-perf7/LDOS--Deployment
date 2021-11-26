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
```
ansible --version
```
Note: the path to ansible.cfg  path to python & python version..  

browse ansible directory:
```
cd   /etc/ansible
ls -lrt
```
Note: the directory & configuration files.
* roles - directory for ansible roles
* hosts - inventory file
* ansible.cfg - ansible configuration file

  > for further information: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#


clean up:
```
sudo yum remove ansible -y
```

---