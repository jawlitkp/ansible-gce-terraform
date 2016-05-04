## Usage
### Create a vars.yaml file under this repo folder

With contents like:
 
```
---
gce_project: GCE PROJECT NAME
gce_region: GCE REGION
gce_zones: 
  - "{{gce_region}}-c"
  - "{{gce_region}}-b"
  - "{{gce_region}}-a"
gce_json_creds: LOCATION OF GCE JSON CREDENTIALS FILE
gce_pem_creds: LOCATION OF GCE PEM FILE (created as described in the [credentials section](http://docs.ansible.com/ansible/guide_gce.html) of ansible gce guide)
gce_prefix: UNIQUE GCE NAMING PREFIX
gce_public_key: PATH TO PUB KEY FOR GCE INSTANCES
gce_domain: DOMAIN FOR GCE HOST
gce_zone: PRE-Created GOOGLE CLOUD DNS ZONE NAME (e.g. maratoid-zone)
repo_branch: tornado
redis_login: PICK ANY NAME
redis_pw: PICK ANY PASSWORD
```

### Make sure ansible and terraform are installed 
Install latest terraform and ansible

### Run ./up.sh

No parameters:

```
./run.sh
