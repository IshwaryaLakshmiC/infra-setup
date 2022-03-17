#!/bin/bash
sudo ansible-playbook ec2create.yaml
if [[ '$?' == '0' ]]
then
        echo 'Instance created'
        sudo ansible-playbook checkid.yaml
        if [[ '$?' == 0 ]]
        then
                echo 'Server Reachable as root'
                sudo ansible-playbook kubernetes_ubuntu.yaml
                if [[ '$?' == 0 ]]
                then
                        echo 'Docker Installation and minikube setup has been done successfully'
                        sudo ansible-playbook nginx_config.yaml
			if [[ '$?' == 0 ]] 
			then
				echo 'nginx installation has been done successfully'
			else
				echo 'nginx not installed'
			fi

                else
                        echo 'Minikube setup not done'
                fi

        else
                echo 'Unable to create the server'
        fi
else
        echo 'unable to create the server'
fi

