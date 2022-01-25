# MongoDB-GKE-cluster

Deploying a k8s [mongodb](https://www.mongodb.com/) cluster consist of two replicas (1 primary pod and 1 secondary pod) linked to a nodejs simple app that generates dummy mock data to be sent as continuous requests.

## Infrastructure

Infrastructure provisioned using [Terraform](https://www.terraform.io/) as IAC tool on Google cloud platform, basically it contains 2 subnets one provided with natgateway and one virtual machine, the other hosts GKE cluster with 3 replica nodes.

## Kubernetes deployments

- a deployment for nodejs application that works as a mock TCP data server, once this server is connected it will generate a stream of JSON objects.
- a stateful-set of two replicas for mongoDB cluster definig one replica to be the primary host and the other one to be secondary.     

## installation
to run the application you need to initiate the infrastructure by running terrform plan,apply commands. 
```bash

$ Terraform init

$ Terraform plan

$ Terraform apply

```
then ssh on the created vm, download kubectl and connect to the GKE cluster
after that start deploying k8s mongo.yaml file then deploy the headless service then the application deployment
```bash

$ kubectl apply -f filename

```
