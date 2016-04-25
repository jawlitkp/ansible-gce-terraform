## Usage
### Create a vars.yaml file under this repo folder

With contents like:
 
```
---
gce_project: GCE PROJECT NAME
gce_region: GCE REGION
gce_zone_foo: AZ FOR FOO INSTANCES
gce_zone_bar: AZ FOR BAR INSTANCES
gce_json_creds: LOCATION OF GCE JSON CREDENTIALS FILE
gce_prefix: UNIQUE GCE NAMING PREFIX
gce_public_key: PUB KEY FOR GCE INSTANCES
gce_aws_az: AWS ROUTE53 ZONE ID 
gce_domain: DOMAIN FOR GCE HOST
gce_hostprefix: PREFIX FOR GCE DOMAIN (i.e forwarding rule will point to gce_hostprefix.gce_domain)
```

### Make sure ansible and terraform are installed 
Install latest terraform and ansible

### Run ./up.sh

No parameters:

```
./run.sh
