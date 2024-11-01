# HIJRA SRE Technical Test

## What I've Done
1. **Containerized Spring Boot Application**: Create a `Dockerfile` to containerize the spring boot app.
2. **Terraform**: Wrote Terraform code for provisioning GCP Infrastrcuture.
    - `infra/terraform/`
3. **Ansible**: Wrote Ansible Script to automate all the process inside VM Machine.
    - `infra/ansible/`
3. **CI/CD Pipeline**: Configured a GitHub Actions workflow for CI/CD:
    - Workflow file: `.github/workflows/cicd.yaml`
4. **Observability**:
    - **Grafana and Prometheus**: as metrics monitoring.
        - `infra/docker/01-prometheus/`
        - `infra/docker/02-grafana/`
    - **ELK Stack**: as logging system.
        - `infra/docker/03-elk-stack/`
5. **PostgreSQL**: to store persistent data.
    - `infra/docker/04-postgresql/`

## Architecture
### Release Process
![Release Process](https://github.com/mxibrahim/spring-petclinic/blob/main/infra/diagrams/release-process.png?raw=true)

### Infrastructure Diagram
![Infrastructure Diagram](https://github.com/mxibrahim/spring-petclinic/blob/main/infra/diagrams/infrastructure-diagram.png?raw=true)


---
## How to Setup
**Prerequisites:**
- GCP Project
- Gcloud
- Terraform
- Ansible

### 1. Provisioning GCP Infrastructure with Terraform
- Create Service Account for Terraform, give access as editor (or you can change with spesific access role), then download json key file. https://cloud.google.com/iam/docs/keys-create-delete
- Run terraform apply:
```
GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
cd infra/terraform
terraform init
terraform plan # for check creates an execution plan
terraform apply
```

### 2. Setup and Configuration VM Instance with Ansible
```
cd infra/ansible
ansible-playbook -i 00-inventory.yaml 01-setup-docker.yaml
ansible-playbook -i 00-inventory.yaml 02-deploy-docker-services.yaml
ansible-playbook -i 00-inventory.yaml 03-setup-node-exporter.yaml
ansible-playbook -i 00-inventory.yaml 04-setup-nginx.yaml
ansible-playbook -i 00-inventory.yaml 05-setup-filebeat.yaml
```

### 3. Run CI/CD Pipeline
- Create Variable and Secrets in Repository Settings:
    - Variable: `DOCKERHUB_USERNAME`
    - Secret: `DOCKERHUB_TOKEN`
    - Secret: `SSH_PRIVATE_KEY`
- Trigger Github Action Pipeline:
    - Make some changes
    - commit
    - push to `main` branch

## How to Access Applications and Monitoring
- Get VM Instance External IP
```
gcloud compute instances describe hijra-server \
--format="get(networkInterfaces[0].accessConfigs[0].natIP)"
``` 

- Add this 4 domains into `/etc/hosts`, change `<IPADDRESS>` with VM Instance External IP
```
# add this to /etc/hosts
<IPADDRESS> petclinic.local
<IPADDRESS> grafana.local
<IPADDRESS> prometheus.local
<IPADDRESS> kibana.local
```

#### Access: Petclinic App
[http://petclinic.local](http://petclinic.local)
![petclinic](https://github.com/mxibrahim/spring-petclinic/blob/main/infra/diagrams/petclinic.png?raw=true)

#### Access: Grafana
[http://grafana.local](http://grafana.local), import grafana from dashboard infra/docker/02-grafana/server-dashboard.json
![grafana](https://github.com/mxibrahim/spring-petclinic/blob/main/infra/diagrams/grafana-vm-dasboard.png?raw=true)

#### Access: Kibana
[http://kibana.local](http://kibana.local)
![kibana](https://github.com/mxibrahim/spring-petclinic/blob/main/infra/diagrams/kibana-logs.png?raw=true)

