## <font color='red'>Pre-flight</font>
The following pre-requiste steps have been completed and are listed just for reference.  



### <font color='red'>Skytap Lab</font>
The SkyTap Lab environment is configured with: 

SkyTap DNS: 10.0.0.254 - This is automatically assigned.  
Domain Name: skytap.example  

| Server Name               | Host              |  IP address | OS               |
| ------------------------- | ------------------| ----------- | ---------------- |
| Pentaho Server 9.1.0.2    | pentaho-server-1  | 10.0.0.1    | Unbuntu 18.0.4   |
| LDOS 1.2.0 Master Node 1  | k8s-master-node-1 | 10.0.0.101  | CentOS 7.5       |    
| LDOS 1.2.0 Master Node 2  | k8s-master-node-2 | 10.0.0.102  | CentOS 7.5       |
| LDOS 1.2.0 Master Node 3  | k8s-master-node-3 | 10.0.0.103  | CentOS 7.5       |
| LDOS 1.2.0 Installer      | installer         | 10.0.0.99   | Unbuntu 18.0.4   | 
|


VM sequence: LDOS Master 1-3 : Pentaho Server 9.1.0.2 : LDOS 1.2.0 Installer   


![SkyTap Lab](assets/skytap_lab.png)


---


### <font color='red'>LDOS 1.2.0 Master Nodes</font>
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
Note: the password is 'lumada'  

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

Other recommended packages:

install openssh server-client & python3:
```
apt install openssh-server openssh-client python3
```
install pip3 & upgrade:
```
apt install python3-pip  --upgrade pip
```
install Ansible 2.9.6:
```
pip3 install botocore boto3 ansible==2.9.6
```
install Git:
```
apt install git
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
ssh-copy-id k8s@10.0.0101 (10.0.0.102, 10.0.0.103)
```
Note: do not copy over private key  

test passwordless ssh connection:
```
ssh -i ~/.ssh/id_rsa  k8s@10.0.0.101
```


---


### <font color='red'>Pentaho Server</font>


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


---