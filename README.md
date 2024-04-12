## CNS-DEVOPS-ASSESSMENT
![Cloudformation](https://img.shields.io/badge/Canstar-CloudFormation-blue)
![Build status](https://img.shields.io/badge/Build-Infrastructure%20Jobs-orange)
![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/569/badge)

Welcome to the DevOps Assessment. This assessment contains 5 sections

- [Availability](./assessment/aws-coding-challenge/) - 15%
- [Containerisation](./assessment/containerisation/) - 35%
- [Monitoring/Logging](./assessment/monitoring/) - 10%
- [Optimisation](./assessment/optimisation/) - 15%
- [Security](./assessment/security/) - 25%
## Minimum Requirement
To solve the cns-devops-assessment, you will be required to have Linux based operating system such as Ubuntu, MAC OS etc. if you are on Windows then it is highly recommended to use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install).
### Minimum Base Installations
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Docker with K8s](https://docs.docker.com/desktop/kubernetes/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Python](https://www.python.org/downloads/)
- [Go](https://go.dev/doc/install)
### Optional Installations
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) or
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/) or 
- [microk8s](https://microk8s.io/#install-microk8s) or
- any other local kubernetes cluster for this assessment.

You can also use a simple, interactive and fun playground to do this assessment via https://labs.play-with-k8s.com/
## Task Details
This assessment consists of a set of performance-based items (problems) to be solved in a command line and candidates have few days to complete the task which has been provided under the assessment folder. Each folder contains, it's own `README.MD` file which contains every information which is required by the candidate to solve the problem. Before you start solving porblem, don't forget to execute the `deploy.sh`.
```
cd resources/k8s/
./deploy.sh 
```
## How do I use this repository?
- Clone the repository to your local file system code
```
git clone git@bitbucket.org:canstar-dev/cns-devops-assessment.git
cd cns-devops-assessment 
```
- Create a branch of the repository with the same task name found in Jira
- Git Pull and then checkout the branch you created before
- Make changes to code and commit with sensible commit messages using commit -m or commit -s

## Contributing
Welcome to Canstar DevOps Assessment! To learn more about contributing to the CNS DEVOPS ASSESSMENT code repo, check out the [Contributor's guide](CONTRIBUTING.MD).
## Support
If you need support, start with the original documentations, and work your way through the process that they've outlined. That said, if you have questions, reach out to us one way or another via devops@canstar.com.au



