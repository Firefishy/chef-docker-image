# Chef Docker Image

This repository provides a GitHub Action workflow to automatically build and publish a Docker image based on the latest [chef/chef](https://hub.docker.com/r/chef/chef) image. The resulting image is published to GitHub Container Registry at `ghcr.io/firefishy/chef-docker-image:latest`.

This reposirory will be redundant when upstream issue https://github.com/chef/chef/issues/13907 has been resolved.

## Repository Contents

- **Dockerfile**: Defines the Docker image, which extends `chef/chef:latest`.
- **GitHub Workflow**: The workflow located at `.github/workflows/docker-publish.yml` automates the build and push process to GitHub Container Registry.

## Usage

To use the image, pull it from GitHub Container Registry:

```sh
docker pull ghcr.io/firefishy/chef-docker-image:latest
```

## GitHub Actions Workflow

The workflow in this repository, `.github/workflows/docker-publish.yml`, triggers on every push to the main branch and builds the Docker image. The built image is then pushed to GitHub Container Registry under `ghcr.io/firefishy/chef-docker-image:latest`.

### Workflow Configuration

The workflow file contains the following steps:

1. **Checkout**: Checks out the repository.
2. **Login to GitHub Container Registry**: Authenticates with GitHub Container Registry.
3. **Build and Push Docker Image**: Builds the Docker image from the Dockerfile and pushes it to `ghcr.io/firefishy/chef-docker-image:latest`.

## Contributing

Contributions to improve this Docker image or workflow are welcome. Please submit a pull request with your changes.

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for more information.