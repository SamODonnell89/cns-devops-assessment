#!/usr/bin/env bash

naemspaces=(
        "team-red"
        "team-purple"
        "team-blue"
        "team-green"
        "docker-hacker"
        "moon"
    )

deployments=(
        "immutable-deployment"
        "secret-handler"
    )

secrets=(
    "secret2"
)

create_namespace () {
    dir=${PWD##*/}   # set a dir varaible for current folder
    echo "Checking Directory..." $dir
    for naemspace in ${naemspaces[@]}; 
    do  
        if [ "$dir" != "k8s" ]
        then 
            echo "Your repositories are not under k8s folder."
        else
            kubectl create ns $naemspace
        fi
    done
}

create_secret () {
    dir=${PWD##*/}   # set a dir varaible for current folder
    echo "Checking Directory..." $dir
    for secret in ${secrets[@]}; 
    do  
        if [ "$dir" != "k8s" ]
        then 
            echo "Your repositories are not under k8s folder."
        else
            kubectl apply -f $secret.yaml
        fi
    done
}

create_deployment () {
    dir=${PWD##*/}   # set a dir varaible for current folder
    echo "Checking Directory..." $dir
    for deployment in ${deployments[@]}; 
    do  
        if [ "$dir" != "k8s" ]
        then 
            echo "Your repositories are not under k8s folder."
        else
            kubectl apply -f $deployment.yaml
        fi
    done
}

main () {
    # calling function
    create_namespace 
    create_secret
    create_deployment
}

main "@"

