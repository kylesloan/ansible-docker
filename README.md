# ansible-docker

Docker hub builds: https://cloud.docker.com/repository/docker/ksloanatathenahealth/ansible-docker

Pip sometimes blows up, so use a stable docker image so everyone can have the following:

- dynamic inventory vmware - https://docs.ansible.com/ansible/latest/plugins/inventory.html#inventory-plugins - see section below on usage

- jmespath for json_query - https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#json-query-filter

- nitrosdk-python for netscaler modules (search ansible main modules area)

# help bin wrappers

```
cat ~/bin/ansible-playbook
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible-playbook "$@"
```

```
cat ~/bin/ansible-inventory
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible-inventory "$@"
```

```
cat ~/bin/ansible
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible "$@"
```

# dynamic inventory with vmware

The vmware endpoint can be queried to generate a list of all systems managed by vmware.  While you could simply make this the inventory file, it can get quiet slow as more and more systems are built.  I would suggest running the inventory look up occasionly and writing it to a flat inventory file that you use for all other calls.  The dynamic file inventory file needs to end in vmware.yml

```
cat inventory.vmware.yml
# Sample configuration file for VMware Guest dynamic inventory
# https://docs.ansible.com/ansible/latest/vmware/vmware_inventory.html
plugin: vmware_vm_inventory
hostname: my-vmcenter.example.com
username: USER@example.com
password: PASSWORD
strict: False
validate_certs: False
with_tags: True
```

```
```
If you use vmware tags, this will make an ansible group of all hosts that share that tag. Tags can be found after selecting a host, then ACTIONS > Tags & Custom Attributes.

```
ansible-inventory --list --yaml -i inventory.vmware.yml > inventory.flat.yml

ansible my-custom-vm-tag -i inventory.flat.yml -m raw -a "hostname" -u root -k
```

Note that if you do not get a working flat file back, it might be due to either login infomation being incorrect, or the version of ansible being used not having this PR in it - https://github.com/ansible/ansible/issues/52381.  This docker image does have the fix in place.


# updating
You should make a git tag when you do a change so docker hub keeps that image in a place where it can be pulled for historical reasons.
