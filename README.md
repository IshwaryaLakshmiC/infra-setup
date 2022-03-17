# infra-setup
In this repository aim is to create an EC2 instance and install nginx service on it. It is achieved by the following steps. 
Primarily, it is advised to create an IAM role for full EC2 access and attach it to the bastion. As in this script, I  have not implemented passing access keys and values directly. 

Considering, all the prerequiste packages are installed (refer requirement.txt) we can proceed running the scripts. 

In this repo, Shell scripts are used to monitor the health status of the server, which can be added as a cron job and ansible playbooks for installation and conifgurations. 

Infrastructure: 
  EC2 instance created (ubuntu)
  Docker, kubectl, minikube is installed
  Nginx is deployed and the port is exposed.
  
script.sh
  Upon executing this script, the underlying playbooks are executed. 
  1. Creating the EC2 instance is done at first. ec2create.yaml file will be executed. The EC2 instance at us-east-2 location will be created with default SG, VPC settings. 
  2. Upon successful creation, other steps are executed. But right now, the flow will fail. 
  3. Manual intervention of the following is required - adding the new ec2 instance to the /etc/ansible/hosts file. Right now, an exisiting keypair is used so, authentication shall happen without any manul intervention. And creating the user for docker, minikube setup need to be taken care. I have created user_create.yaml to automate this process, but adding the authentication back to bastion requires attention. 
  4. Later, the script shall execute checkid.yaml - this is to ensure whether the server is reachable and root is accessible. This is optional but I have added it to ensure the privileges are sufficient for the user. 
  5. Upon successful execution of checkid.yaml file, the kubernetes_ubuntu.yaml shall be executed.

kubernetes_ubuntu.yaml

Upon running this file, the necessary repositories shall be fetched at first. Then, the installation of docker, minikube and all the dependent packages shall happen in linear fashion. 

Ensure the EC2 instance type is having more than one CPU core and atleast 2GB RAM. This configuration is required for the minikube to run. 

Once the setup is done successfully, nginx deployment shall take place. 

nginx_config.yaml

The deployment file is copied from the local to the remote server. And the necessary commands are executed in the remote server for the nginx setup. After successfully installing the server, here service is exposed directly (went with that for simplicity), the service url is passed to a variable and printed by the script. 

Once this step is also complete, the script for the health check can be added to the bastion or from where the monitoring need to be done. 

Enhancements:

For simplicity went with minikube installation, which shall be replaced by kubernetes (master and worker nodes) in the realtime. 
The Access key and values can be passed via ansible vault if the local server is not in the AWS itself. 
For the nginx part, Ingress controller can be a better fit where multiple services can be added in future too rather than using nodeport. 
