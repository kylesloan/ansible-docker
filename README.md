# ansible-docker

Docker hub builds: https://cloud.docker.com/repository/docker/ksloanatathenahealth/ansible-docker

Pip sometimes blows up, so use a stable docker image so everyone can have the following:

- dynamic inventory vmware - https://docs.ansible.com/ansible/latest/plugins/inventory.html#inventory-plugins

- jmespath for json_query - https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#json-query-filter

- nitrosdk-python for netscaler modules (search ansible main modules area)

# help bin wrappers

```
cat ~/bin/ansible-playbook
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible-playbook $@
```

```
cat ~/bin/ansible-inventory
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible-inventory $@
```

```
cat ~/bin/ansible                                                                                                                                                   
#!/bin/bash
docker run -it --rm -v $(pwd):/mnt/ansible ksloanatathenahealth/ansible-docker ansible $@
```

# updating
You should make a git tag when you do a change so docker hub keeps that image in a place where it can be pulled for historical reasons.
