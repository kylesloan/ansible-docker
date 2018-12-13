FROM python:2-stretch
RUN apt-get update && apt-get install -y vim
RUN pip install ansible

# https://github.com/vmware/vsphere-automation-sdk-python
RUN git clone https://github.com/vmware/vsphere-automation-sdk-python.git && cd vsphere-automation-sdk-python && pip install --upgrade --force-reinstall -r requirements.txt --extra-index-url file:///vsphere-automation-sdk-python/lib
