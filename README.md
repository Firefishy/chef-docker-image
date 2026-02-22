# Chef Docker Image

> **This project has been archived and is no longer maintained.**

## Why this project is archived

Chef has made a series of licensing changes that increasingly restrict use by the Open Source community:

- [Changes to runtime licensing for Chef gem users](https://www.chef.io/blog/changes-to-runtime-licensing-for-chef-gem-users)
- [CI pipeline issues affecting Chef Workstation users](https://www.chef.io/blog/important-information-for-chef-workstation-users-facing-ci-pipeline-issues-when-running-test-kitchen)

These changes have made it impractical to continue maintaining this project as an open-source effort.

## Recommended alternative

We encourage everyone to consider [CINC](https://cinc.sh/) — a community-driven, fully Open Source distribution built from Chef's source code, free of proprietary licensing restrictions. CINC is a drop-in replacement and is actively maintained by the community.

---

## Original description

This repository provided a GitHub Action workflow to automatically build and publish a Docker image based on the latest [chef/chef](https://hub.docker.com/r/chef/chef) image. The resulting image was published to GitHub Container Registry at `ghcr.io/firefishy/chef-docker-image:latest`.

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
