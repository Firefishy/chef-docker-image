ARG OS_RELEASE="22.04"
ARG CHEF_VERSION="18.8.11"
ARG CHEF_PLATFORM="ubuntu"

FROM ubuntu:${OS_RELEASE}

# Re-declare build args so they are available in later stages
ARG OS_RELEASE
ARG CHEF_VERSION
ARG CHEF_PLATFORM
ARG TARGETARCH

# Install Chef
# hadolint ignore=DL3008
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates; \
    \
    # Map Docker's TARGETARCH to the Chef arch
    case "${TARGETARCH}" in \
      "amd64") chef_arch='amd64';; \
      "arm64") chef_arch='arm64';; \
      "arm64/v8") chef_arch='arm64';; \
      *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1;; \
    esac; \
    \
    # Build the Chef package name and download URL
    chef_package="chef_${CHEF_VERSION}-1_${chef_arch}.deb"; \
    chef_url="https://packages.chef.io/files/stable/chef/${CHEF_VERSION}/${CHEF_PLATFORM}/${OS_RELEASE}/${chef_package}"; \
    \
    # Download and install the .deb
    echo "Downloading Chef from $chef_url"; \
    wget -q -O "/tmp/${chef_package}" "${chef_url}"; \
    apt-get install -y --no-install-recommends "/tmp/${chef_package}"; \
    \
    # Cleanup
    rm -f "/tmp/${chef_package}"; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

# check chef-client and bundle ruby are functional
RUN ["/opt/chef/bin/chef-client", "--version"]
RUN ["/opt/chef/bin/ruby", "--version"]

VOLUME ["/opt/chef"]
