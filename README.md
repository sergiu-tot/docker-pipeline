# docker-pipeline

Deploy a Jenkins instance on your local laptop, and create a pipeline to test a dummy app.

Clone the current repo locally, so you have access to all the files.

## Pre-requisites

The provisioning of the Jenkins VM is achieved using VirtualBox as hypervisor and Vagrant as IaC tool.

Download and install both of them:
- https://www.virtualbox.org/wiki/Downloads
- https://developer.hashicorp.com/vagrant/install

Once Vagrant is installed, install the `vagrant-vbguest` also. This plugin will handle the installation of the VirtualBox guest additions automatically. This will allow us to share the local folder with the Jenkins VM.

`vagrant plugin install vagrant-vbguest`

## Provision the Jenkins VM

Provision the VM using vagrant by running the following command in the repo directory (where the `Vagrantfile` is located):

`vagrant up`

The process will take a few minutes.

> There are some issues currently with the Jenkins mirrors. Make sure to configure your VPN to use a non-romanian gateway (e.g. Germany) so that you'll be able to install Jenkins and it's plugins.

Once the Jenkins VM is provisioned you can access the UI at the following URL:

- http://localhost:8080/

Authenticate with user `admin` and password `admin`.

Immediately after the authentication, on the first start, you'll be asked to install a set of plugins. Chose the "Install suggested plugins" option.

After the installation is done go to `Manage Jenkins > Plugins` section and install the following plugins also:

- Blue Ocean
- Pipeline Stage View

Vagrant commands:
- `vagrant up` - starts the VM defined in the `Vagrantfile`, and run the provisioning step if it's the first start
- `vagrant halt` - stops the VM
- `vagrant destroy` - this will destroy the VM, losing all the data inside it
- `vagrant status` - check the status of the currently deployed machines
- `vagrant ssh <machine-name>` - remotely log-in to the VM using ssh

## Check Jenkinsfile

- observe the pipeline structure
- options for the pipeline
- define stages and steps
- observe the parallel steps option
- docker commands using the shell execution
- user and group id passed to the container when started
- volume mounts
- override the entrypoint
- post-execution actions: publish junit reports, and archive artifacts

## Create pipeline in Jenkins

- manually create the pipeline in jenkins
- use git scm on the specified branch (main)
- specify the location for Jenkinsfile
- run the pipeline
- check artifacts
- check logs

## Check Blue Ocean interface

- open the blue ocean interface
- check parallelism
