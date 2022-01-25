## <font color='red'>LDOS 1.2.0: Installation & Configuration</font>
The following workshop is intended to highlight an on-premise bare-metal installation and configuration of LDOS 1.2.0. The installation and configuration steps have been modified for a training environment and therefore are <font color='red'>NOT</font> to be used for a production environment.

#### <font color='red'>Module 01 - Infrastructure</font>
* Configure SkyTap Lab
* Ansible
* HA Proxy

#### <font color='red'>Module 02 - Pre-flight</font>
* Download Kubespray 1.24
* Configure env.properties
* Configure extra-vars.yml
* Configure hosts-skytap.yml
* Run preflight_hardware.yml playbook

#### <font color='red'>Module 03 - Foundry Platform</font>
* Run cluster.yml playbook
* Run pre-flight_foundry.yml playbook
* Run install_foundry.yml playbook

#### <font color='red'>Module 04 - LDOS</font>
* Install Metrics-addon server
* Run pre-flight_nfs.yml (optional)
* Configure env.properties
* Run install_ldos.yml playbook
* Post Installation tasks

#### <font color='red'>Module 05 - Upgrades</font>
* Upgrade LDOS 1.1.1 -> 1.2.0
* Simple dataflows
* ElasticSearch
* Kibana
* Prometheus