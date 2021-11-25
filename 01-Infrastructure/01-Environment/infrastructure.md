## <font color='red'>Pre-requisites</font>
The following pre-requiste steps have been completed and are listed just for Lab reference. 

This reference section covers:
  * Setup SkyTap Lab environment. 
     
  * Setup of LDOS 1.2.0 Master / Worker Nodes.  
  * Setup of LDOS 1.2.0 Installer.
  * Setup of HAProxy 2.4
  * Setup of Pentaho Server 9.2

  * Generate SSH keys & deploy


---


### <font color='red'>Skytap Lab</font>
The SkyTap Lab environment is configured with: 

SkyTap DNS: 10.0.0.254 - This is automatically assigned.  
Domain Name: skytap.example  

| Server Name               | Host              |  IP address | OS               |
| ------------------------- | ------------------| ----------- | ---------------- |
| Pentaho Server 9.2        | pentaho-server-1  | 10.0.0.1    | Unbuntu 18.0.4   |
| LDOS 1.2.0 Master Node 1  | k8s-master-node-1 | 10.0.0.101  | CentOS 7.5       |    
| LDOS 1.2.0 Master Node 2  | k8s-master-node-2 | 10.0.0.102  | CentOS 7.5       |
| LDOS 1.2.0 Master Node 3  | k8s-master-node-3 | 10.0.0.103  | CentOS 7.5       |
| LDOS 1.2.0 Installer      | installer         | 10.0.0.99   | Unbuntu 20.04.3  | 
|


VM sequence: LDOS Master 1-3 : Pentaho Server 9.2 : LDOS 1.2.0 Installer   


![SkyTap Lab](../assets/skytap_lab.png)


---


### <font color='red'>LDOS 1.2.0 Master / Worker Nodes</font>
These servers were deployed as CentOS 7.5 Firstboot images.
Each of the nodes in the cluster has been configured with a 'k8s' user with sudo priviliges.

add a 'k8s' user to the wheel group (log in as root):
```
useradd k8s -aG wheel
```
add password:
```
passwd k8s
```
Note: the password is 'lumada'  

check the assigned groups:
```
groups
```
or for the ids:
```
id k8s
```
check 'k8s' user on any master node:
```
ls /home
```
allow users in group wheel to run all commands without password:
```
nano /etc/sudoers
## Allows users in group wheel to run all commands
%wheel  ALL=(ALL)     ALL

## Without password
%wheel  ALL=(ALL)     NOPASSWD:  ALL
```
save:
```
Ctrl +o
enter
Ctrl + x
```

---


### <font color='red'>LDOS 1.2.0 Installer</font>
This server has been configured with an 'installer' user with sudo privileges.  

update(log in as root) :
```
apt update -y
```
add an 'installer' user :
```
adduser installer
```
Note: password is 'lumada'  

add 'installer' to sudo group
```
usermod -aG sudo installer
```
check the assigned groups:
```
groups
```
or for the ids:
```
id installer
```
check 'installer' user on any master node:
```
ls /home
```
allow users in group wheel to run all commands without password:
```
nano /etc/sudoers
## Allows users in group admin to gain root privileges
%admin  ALL=(ALL)    ALL
%sudo  ALL=(ALL)     ALL  

## Without password
%sudo  ALL=(ALL)     NOPASSWD:  ALL
```
save:
```
Ctrl +o
enter
Ctrl + x
```

### <font color='red'>Other Required Packages on Installer Server</font>
Enusre that the following packages are also installed and configured:
* openssh server and client
* pip & pip3
* git
* visual studio code - just for training purposes 

---


install openssh server & client:
```
apt install openssh-server openssh-client
```

---


install pip3 & upgrade:
```
apt install python3-pip  --upgrade pip
```


---


install git:
```
apt install git
```

---


install Visual Studio Code:
```
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
```
update the package cache and install:
```
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
```


#### <font color='red'>SSH</font>
Generate the required SSH keys to connect to LDOS nodes.

generate ssh key:
```
ssh-keygen
```
Note: keys are located in .ssh directory.

copy over key to k8s user on LDOS nodes:
```
ssh-copy-id k8s@10.0.0.101 (10.0.0.102, 10.0.0.103)
```
Note: this will copy over both the private and public keys.


test passwordless ssh connection:
```
ssh -i ~/.ssh/id_rsa  k8s@10.0.0.101
```


---


### <font color='red'>Pentaho Server 9.2</font>


### <font color='red'>HA Proxy</font>
Install the latest HAProxy using a PPA.

  > browse to: https://haproxy.debian.net/

 Note: use the wizard to generate commands.

 enable PPA (log in as root):
```
 apt-get install --no-install-recommends software-properties-common
 add-apt-repository ppa:vbernat/haproxy-2.4
```
then install:
```
apt-get install haproxy=2.4.\*
```
verify installation:
```
haproxy -v
```
update and upgrade:
```
sudo apt update && sudo apt upgrade -y
```

#### <font color='red'>Configure HAProxy</font>
Configure HAProxy to load-balance across the cluster.

the configuration file is located at:  
/etc/haproxy/haproxy.cfg

Details can be found at: 
  > browse to: https://www.haproxy.com/documentation/hapee/latest/configuration/config-sections/defaults/


rename the existing /etc/haproxy/haproxy.cfg to haproxy.cfg.bak
```

```
copy over 
```


```






---