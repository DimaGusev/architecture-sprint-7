#!/bin/bash

create_user() {
    mkdir -p certs
    openssl genrsa -out "certs/$1.pem" 2048
    openssl req -new -key "certs/$1.pem" -out "certs/$1-csr.pem" -subj "/CN=$1/O=dgusev/"
    openssl x509 -req -in "certs/$1-csr.pem" -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out "certs/$1.crt" -days 10000
    kubectl config set-credentials $1 --client-certificate="certs/$1.crt" --client-key="certs/$1.pem"
    kubectl config set-context $1 --cluster=minikube --user $1
}

create_user dgusev-devops
create_user dgusev-developer
create_user dgusev-operator
create_user dgusev-security-specialist
