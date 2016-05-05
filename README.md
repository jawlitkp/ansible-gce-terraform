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
```

## Summary
Repo code uses a tiny bash script to fire up an ansible playbook, that renders a terraform infrastructure file. Values the terraform file is templated with come form a user-created vars.yaml.
### Terraform
No terraform templating is used, all values are pre-set by Ansible's jinja templating
### GCE
Terraform creates GCE resources that provide a subnetted network, with a URLMap (HTTP) loadbalancer and gce backend services, backed by 3 autoscaling groups.
Each group is in a separate AZ.
Autoscaling groups are running a tornado-based example app, running in a docker container.
All instances running tornado are talking to a single redis instance (also dockerized)

URLMap redirects to each AZ, based on the hostname used. For if your vars.yaml looks like this:
```
gce_domain: derp.io
...
gce_region: us-central1
gce_zones:
  - "{{gce_region}}-c"
  - "{{gce_region}}-b"
  - "{{gce_region}}-a"
...
```

Then, you will end up with redirects:
* 1.derp.io - redirects to instances in us-central1-c
* 2.derp.io - redirects to instances in us-central1-b
* 3.derp.io - redirects to instances in us-central1-a

### Provisioning
Terraform provides a very short cloud-init file to all instances, that contains a minimal ansible inventory and variable files.
Same cloud-init also starts a service, that downloads ansible packaged up into a small alpine-linux based container, and provisions the instance.

We also generate all the files required to run the boxible.yaml playbook against all the hosts using the [gce dynamic inventory script](ansible/inventory)