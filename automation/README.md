DEMO
====

## Webservers
Start 1,2 or maybe 20 instances in Amazon and configure them automatically

Run this demo code with ansible:
```
ansible-playbook -i hosts -e num_servers=1 webservers.yaml
```

You need to set the environment variables AWS_ACCESS_KEY and AWS_SECRET_KEY
to values for your account prior.

## A CoreOS cluster in Digital Ocean

* Get an etcd discovery token
```
curl -w "\n" https://discovery.etcd.io/new
```

* Set the DO_API_TOKEN environment variable to your Digital Ocean
v2 API token.

* If you do not know your ssh key id, use the scripts/do_resources.sh to find it
```
scripts/do_resources.sh account/keys | grep id
```

* Run the demo code that brings up a two node cluster
```
ansible-playbook -i hosts -e droplet_state=present -e discovery_token=XXXX coreos-cluster.yaml
```

* Log in as user core and use fleetctl to check cluster status
