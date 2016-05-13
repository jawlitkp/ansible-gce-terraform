## Usage
### Create a vars.yaml file under this repo folder

With contents like:

```
---
gce_project: GCE PROJECT NAME
gce_region: GCE REGION
gce_zone: AZ to use
gce_json_creds: LOCATION OF GCE JSON CREDENTIALS FILE
gce_prefix: UNIQUE GCE NAMING PREFIX
gce_public_key: PUB KEY FOR GCE INSTANCES
gce_dns_zone: CLOUD DNS ZONE ID
gce_domain: DOMAIN FOR GCE HOST
gce_hostprefix: PREFIX FOR GCE DOMAIN (i.e forwarding rule will point to gce_hostprefix.gce_domain)
```

### Make sure ansible and terraform are installed
Install latest terraform and ansible

### Run ./up.sh

No parameters:

```
./run.sh
```

Run it again to test out the destruction of compute instance, without destroying the attached volume.

## Run ./down.sh

No parameters:

```
./down.sh
```

to destroy.

## Summary
Repo code uses a tiny bash script to fire up an ansible playbook, that renders a terraform infrastructure file. Values the terraform file is templated with come form a user-created vars.yaml.
### Terraform
No terraform templating is used, all values are pre-set by Ansible's jinja templating
### GCE
Terraform creates the following in GCE:
A network
A sub-network
A persistent 50 GB disk
A compute instance
A dns record

Once everything created a small static page webserver is started serving a page with time of creation @ gce_hostprefix.gce_domain. Page is stored on the persistent disk and is populated by simply appending $(date) to index.html.
Running

```
./run.sh
```

more than once destroys/recreates the compute instance but not the disk - multiple runs should get you a page with multiple dates

Terraform times out sometimes on destruction/creation. Just run the appropriate script again.