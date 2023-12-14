The main motto of this task is:
1) To create a simple Nodejs Application and creating a docker image of it.
2) To push the image to Container Registry either ECR or DockerHub. 
3) To create an ecs infra using Terraform for AWS provider.
4) To host the simple node app on ecs by mentioning the docker image of node app to main.tf file.
5)  Using Jenkins CI/CD declarative pipleine to deploy the node app.

Here we will be going to use github webhook trigger for CI/CD, so that if any changes commited on this repo it will trigger the jenkins pipeline.
