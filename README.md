# aws-codebuild-extras
Add extra information of your AWS CodeBuild build via environment variables.

Use `docker.sh` to generate docker tags for a build.

## Usage

Add the following command to the `install` or `pre_build` phase of your buildspec:

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/rxrevu/aws-codebuild-extras/master/install)"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/rxrevu/aws-codebuild-extras/master/docker.sh)"
