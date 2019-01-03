FROM python:2-stretch
RUN apt-get update && apt-get install -y vim
RUN pip install ansible

# for dynamic vsphere inventory https://github.com/vmware/vsphere-automation-sdk-python
RUN git clone https://github.com/vmware/vsphere-automation-sdk-python.git && cd vsphere-automation-sdk-python && pip install --upgrade --force-reinstall -r requirements.txt --extra-index-url file:///vsphere-automation-sdk-python/lib

# for json_query filter - https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#json-query-filter
# "You need to install \"jmespath\" prior to running json_query filter"
RUN pip install jmespath

# entry point/mnt point
# use -v $(PWD):/mnt/ansible
RUN mkdir -p /mnt/ansible
WORKDIR /mnt/ansible
