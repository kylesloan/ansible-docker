FROM python:3
# sshpass required for ldap ssh actions
RUN apt-get update && apt-get install -y sshpass vim
RUN pip install ansible

# for dynamic vsphere inventory https://github.com/vmware/vsphere-automation-sdk-python
RUN git clone https://github.com/vmware/vsphere-automation-sdk-python.git && cd vsphere-automation-sdk-python && pip install --upgrade --force-reinstall -r requirements.txt --extra-index-url file:///vsphere-automation-sdk-python/lib

# for json_query filter - https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#json-query-filter
# "You need to install \"jmespath\" prior to running json_query filter"
RUN pip install jmespath

# for netscaler calls to work
RUN pip install nitrosdk-python

# https://github.com/ansible/ansible/issues/52381 -- hopefully this line can go away in the future once this makes it into a release of ansible
RUN wget -O /usr/local/lib/python3.7/site-packages/ansible/plugins/inventory/vmware_vm_inventory.py https://raw.githubusercontent.com/ansible/ansible/eaa45346a729fb16f4e15881cdcb37921c23b88f/lib/ansible/plugins/inventory/vmware_vm_inventory.py

# https://docs.ansible.com/ansible/latest/user_guide/vault.html#speeding-up-vault-operations
# make ansible-vault run faster
RUN pip install cryptography

# update the symlink of python as some things point to /usr/bin/python and this blows up not being python3
# leave usr/bin/python2 in place though
RUN rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

# entry point/mnt point
# use -v $(PWD):/mnt/ansible
RUN mkdir -p /mnt/ansible
WORKDIR /mnt/ansible
