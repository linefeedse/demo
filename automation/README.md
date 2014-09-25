DEMO
====

Start 1,2 or maybe 20 instances in Amazon and configure them automatically

Run this demo code with ansible:
```
ansible-playbook -i hosts -e num_servers=1 webservers.yaml
´´´

You need to set the environment variables AWS_ACCESS_KEY and AWS_SECRET_KEY
to values for your account prior.

