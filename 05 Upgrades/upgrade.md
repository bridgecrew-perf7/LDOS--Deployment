## <font color='red'>Lumada DataOps Suite 1.2.0</font>

Please read the documentation: [LDOS 1.2.0 Upgrade & Configuration](resources/LDOS-1.2.1_Upgrade_and_Configuration_Guide.pdf)    

#### <font color='red'>Downloads</font>
All files required for installation are available in the release folder and can be found in the link below.
https://hcpanywhere.hitachivantara.com/a/PWPVYtZj1UovY9VO/e52a0db2-ad14-4673-941b-c304c2b108b2?l

You’ll need your Hitachi Vantara credentials or ask Customer Success.

The following playbook is run:

#### upgrade_ldos.yml
* Create directories
* Prepare env.properties
* Get foundry password
* Populate env.properties template
* Update Hostnames in Helm Charts
* Upgrade LDOS
* Check Pods

---

<em>Run the playbook - upgarde_ldos.yml</em>  
This will upgrade and configure the various required packages.


``run the playbook - upgrade_ldos.yml:``
```
cd /etc/ansible/playbooks
ansible-playbook -i hosts-skytap.yml --extra-vars="@extra-vars.yml" -b -v upgrade_ldos.yml
```

---

#### <font color='red'>Post Upgrade Tasks</font>


Update Catalog app switcher endpoint
After successfully upgrading LDOS, using a browser open Lumada Data Catalog and change the app switcher configuration by going to Manage 
> Configuration > app-server: MISC, and editing the option "Absolute API endpoint of control plane app switcher to return all app configs" to the following value, replacing <HOSTNAME> and <NAMESPACE> by the cluster hostname and Foundry namespace respectively:
https://<HOSTNAME>/<NAMESPACE>/app-switcher/app-switcher-lap-app/api/v1/apps
Save the change and then restart the app-server by going to Manage > Configuration > app-server > Restart app-server.
