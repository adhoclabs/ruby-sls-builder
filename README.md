# ruby-sls-builder

Dockerfile for creating builder container for ruby based serverless applications.

Container is automatically published on [docker hub](https://hub.docker.com/r/ahlops/ruby-sls-builder)

### Usage

```docker pull ahlops/ruby-sls-builder```

### Build latest on Docker Hub

- Push to master, `latest` will automatically build

### Build specific version on Docker Hub

- Tag branch with name like `^/[0-9.]+$/` (ex: `git tag -a 1.0.1 -m "version 1.0.1"`)
- Push tags `git push --tags`
