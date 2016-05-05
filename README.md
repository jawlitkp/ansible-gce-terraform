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
```
## Summary
Repo code uses a tiny bash script to fire up an ansible playbook, that renders a terraform infrastructure file. Values the terraform file is templated with come form a user-created vars.yaml.
### Terraform
No terraform templating is used, all values are pre-set by Ansible's jinja templating
### GCE
Terraform creates the following in GCE:
A network
A sub-network
Two healhchecks (foo, bar)
A forwarding rule and a proxy. Forwarding rul redirects to a GCE urlmap
A URLMap
Two instance group managers (foo, bar) in two different AZs with two attached autoscalers and the required instance templates
Two backend services, one for each group manager
The URL map forwards all http request with /foo/ path to Foo instance manager
The URL map forwards all /bar/ requests to Bar instance manager
All other requests are sent to Foo manager
All instances in foo or bar managers respond with either "foo" or "bar" + their private ip.
Autoscaling on load was verified by setting up a 10 node kubernetes cluster, and the generating load on GCE with with it, using [locust load generator](https://github.com/maratoid/kraken-services/tree/custom_load/loadtest-gce)