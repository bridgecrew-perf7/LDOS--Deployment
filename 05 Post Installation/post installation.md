
## <font color='red'>Post-Installation Tasks</font>  

The following post-installation tasks need to be completed:
* Licenses for Lumada Data Integration
* License for Lumada Data Catalog

* Installation of Dataflow Designer 0.7.0

---

<em>Lumada Data Integration Licenses</em>

<font color='green'>The PDI EE licenses have been copied over.</font>

The LDOS package doesn’t contain licenses.   
Please contact Customer Success or Product Management on how to get a license.  
The Data Transformation Editor and Dataflow Engine require a Pentaho EE license to run.  

Configure the path to the .installedLicenses.xml before you install LDOS.

ensure you are on the HA Proxy server.

``copy Pentaho EE license file (HA Proxy):`` 
 ```
 cd Downloads (or directory where .installedLicenses.xml is located)
 sudo mkdir /data/pdi/licenses
 sudo cp -rfp *.xml /data/pdi/licenses/
```
Note:
LICENSE_PATH=/data/pdi/licenses/.installedLicenses.xml"

Note: When you start Dataflow Transformation Editor, you will need to add the path to licenses.

Data Engineer account credentials:  
user: bwayne
password: bwayne

---

<em>Lumada Data Catalog License</em>  

The Lumada Data Catalog is by default a light version (some functions are disabled).  
Please contact either your account manager or dstraining@hitachivantara.com

``upgrade the Catalog license (Ansible Controller):``
```
kubectl create secret generic ldc-license --from-file=license-features.yaml
 --from-file=ldc-license-public-keystore.p12 -n hitachi-solutions
```
Note: Files must be named license-features.yaml and ldc-license-public-keystore.p12

Navigate to the Solution management UI -> Installed -> Lumada Data Catalog  
``add the following lines to values.yml:``

<pre><code>global:  
  coreSiteSecret: {}  
  ldc:                          <font color='green'> # line 4 </font>  
    licenseSecret: ldc-license  <font color='green'> # line 5 </font> </code></pre> 
 
 Click: Save and the Lumada Data Catalog will activate the license.

Data Steward account credentials:
user: mpayton
password: mpayton

---

