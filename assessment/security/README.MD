# Security Challenge

## Q. Verify Platform Binaries
There are four Kubernetes server binaries located at binaries folder. You're provided with the following verified sha512 values for these:

- kube-apiserver `7045200a3dd3664d94c794466e40fe1983000ba2d5ab8146b797481a9b8158ee8e008c52cf4c98279a6404dbd029945e84764d09145669a58476b7edf5b0c690`
- kube-controller-manager `bc28c47bc332b89ed2ce7508ea89f6c7422648176ac620affc309af2e945aeb87b8ea5d24b2f543f513dcf41de11115b4ef56o8fd98356659b1ef2f3d3758f5b`
- kube-proxy `4b54d9fcef4fb4262b835f32192fd58aa3f43d7702e1289c8e27f963e5453bc3486a3480be022783fb0495240a19a4b71d7959424b2a3461b95a672b8eb9bae0`
- kubelet `635592384d711f755a28dd4o706162aa3a6f9b327421f7ddfc60d6f8b031f0815469e87965130465aa2c5527815bb463e0367b2309568cf60ebf52e2ba60940b`

Delete those binaries that don't match with the sha512 values above.

## A.

Run: `sha512sum kubelet`, `sha512sum kube-proxy`, `sha512sum kube-controller-manager`, `sha512sum kube-apiserver`
`kube-controller-manager` and `kubelet` binaries do not match, hence they have been deleted as instructed.

## Q. Locate Vulnerability
Identify and select the code blocks or lines that cause the vulnerability listed inside the `src` folder Dockerfile by adding # in the end of line.
Save the updated Dockerfile under `/src/new.Dockerfile`

## Q. Immutable Root FileSystem
The Deployment `immutable-deployment` in Namespace `team-purple` should run immutable, it's created from file `/resources/K8s/immutable-deployment.yaml`. Even after a successful break-in, it shouldn't be possible for an attacker to modify the filesystem of the running container.

Modify the Deployment in a way that no processes inside the container can modify the local filesystem, only /tmp directory should be writeable. Don't modify the Docker image.
Save the updated YAML under `/resources/k8s/immutable-deployment-new.yaml` and update the running Deployment.