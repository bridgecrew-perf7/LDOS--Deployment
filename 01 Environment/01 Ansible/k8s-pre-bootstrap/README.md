## <font color='red'>k8s-pre-bootstrap role</font>

> This playbook helps you automate the standard Kubernetes bootstrapping pre-reqs.

</br>

#### <font color='red'>Supported OS</font>
The playbook runs on the following OS: 
- CentOS 7
- CentOS 8

</br>

#### <font color='red'>Required Ansible</font>
Ansible version required: `2.10+`

</br>

#### <font color='red'>Tasks in the role</font>
This role will run the following tasks:
- Copy over SSH keys
- Install basic required packages
- Setup standard system requirements - Disable Swap, Modify sysctl, Disable SELinux
- Install and configure a container runtime of your Choice - cri-o, Docker, Containerd
- Install the Kubernetes packages - kubelet, kubeadm and kubectl
- Configure Firewalld on Kubernetes Master and Worker nodes (Only Kubernetes <1.19 version)

</br>

#### <font color='red'>How to use this role</font>
Clone the GitHub repository:

k8s-pre-bootstrap
  - hosts         # example inventory ansible hosts
  - k8s-prep.yml  # move to /etc/ansible/playbooks
  roles
    - kubernetes-bootstrap folder # move to /etc/ansible/roles

Configure `/etc/hosts` file on the Ansible Controller with all nodes and ip addresses. 

Example:
```
10.0.0.2 k8smaster01.example.com k8smaster01
10.0.0.3 k8snode01.example.com k8snode01
10.0.0.4 k8snode02.example.com k8snode02
```
Note: 
You will need to edit the domain name to match your SkyTap environment. Make a note of the domain name. 

Update your inventory, for example:
```
cd /etc/ansible
sudo nano hosts
```
add the following:
```
[k8snodes]
k8smaster01
k8snode01
k8snode02
```

Update variables in playbook file:
```
cd /etc/ansible/playbooks
sudo nano k8s-prep.yml
```
check the following:
```
---
- name: Setup Variables and Proxy
  hosts: k8snodes
  remote_user: centos
  become: yes
  become_method: sudo
  #gather_facts: no
  vars:
    k8s_version: "1.18"                                  # Kubernetes version to be installed
    selinux_state: permissive                            # SELinux state to be set on k8s nodes
    timezone: "Africa/Nairobi"                           # Timezone to set on all nodes
    k8s_cni: calico                                      # calico, flannel
    container_runtime: cri-o                             # docker, cri-o, containerd
    pod_network_cidr: "10.0.0.0/16"                      # pod subnet if using cri-o runtime
    configure_firewalld: false                           # true / false (keep it false, k8s>1.19 have issues with firewalld)
    # Docker proxy support
    setup_proxy: false                                   # Set to true to configure proxy
    proxy_server: "proxy.example.com:8080"               # Proxy server address and port
    docker_proxy_exclude: "localhost,127.0.0.1"          # Adresses to exclude from proxy
  roles:
    - kubernetes-bootstrap
```
Note: 
if you are using non root remote user, then set username and enable sudo:

```
become: yes
become_method: sudo
```
To enable proxy, set the value of `setup_proxy` to `true` and provide proxy details.

</br>

#### <font color='red'>Running Playbook</font>
Once all values are updated, you can then run the playbook against your k8snodes.
If your master nodes don't contain `master` and nodes don't contain `node or worker` as part of its hostname, update the file to reflect your naming pattern. 

My nodes are named like below:
```
k8smaster01
k8smaster02
k8snode01
k8snode02
....
```
Check the file:
```
cd /etc/ansible/roles/kubernetes-bootstrap/tasks
sudo nano configure_firewalld.yml
```
Check the pattern:
```
....
- name: Configure firewalld on master nodes
  ansible.posix.firewalld:
    port: "{{ item }}/tcp"
    permanent: yes
    state: enabled
  with_items: '{{ k8s_master_ports }}'
  when: "'master' in ansible_hostname"

- name: Configure firewalld on worker nodes
  ansible.posix.firewalld:
    port: "{{ item }}/tcp"
    permanent: yes
    state: enabled
  with_items: '{{ k8s_worker_ports }}'
  when: ("'node' in ansible_hostname" or "'worker' in ansible_hostname")

```

If your master nodes doesn't contain `master` and nodes doesn't have `node or worker` as part of its hostname, update the file to reflect your naming pattern. My nodes are named like below:

```
k8smaster01
k8smaster02
k8snode01
k8snode02
....
```

Check playbook syntax to ensure no errors:
```
ansible-playbook --syntax-check k8s-prep.yml 

playbook: k8s-prep.yml
```

Playbook executed as root user - with ssh key:
```
ansible-playbook -u centos -k /etc/ansible/playbooks/k8s-prep.yml --extra-vars "ansible_sudo_pass=centos  user=centos group=centos pubkeypath=~/.ssh/id_rsa.pub"
```


Execution should be successful without errors:

```
TASK [kubernetes-bootstrap : Reload firewalld] *********************************************************************************************************
changed: [k8smaster01]
changed: [k8snode01]
changed: [k8snode02]

PLAY RECAP *********************************************************************************************************************************************
k8smaster01                : ok=23   changed=3    unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
k8snode01                  : ok=23   changed=3    unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
k8snode02                  : ok=23   changed=3    unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
```
