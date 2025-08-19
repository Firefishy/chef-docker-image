ARG OS_RELEASE="22.04"
ARG CHEF_VERSION="18.7.10"
ARG CHEF_PLATFORM="ubuntu"

FROM ${CHEF_PLATFORM}:${OS_RELEASE}

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
    # If using Debian 11, 12, or 13 and arm64, override to Ubuntu 22.04 for Chef package
    # If using Debian 12 or 13 and amd64, use Debian 11 for Chef package
    chef_platform="${CHEF_PLATFORM}"; \
    os_release="${OS_RELEASE}"; \
    if [ "$chef_platform" = "debian" ]; then \
      if [ "$chef_arch" = "arm64" ]; then \
        case "$os_release" in \
          "11"|"12"|"13") \
            chef_platform="ubuntu"; \
            os_release="22.04"; \
            echo "Switching to Ubuntu 22.04 for arm64 on Debian $os_release";; \
        esac; \
      elif [ "$chef_arch" = "amd64" ]; then \
        case "$os_release" in \
          "11"|"12"|"13") \
            os_release="11"; \
            echo "Switching to Debian 11 for amd64 on Debian $os_release";; \
        esac; \
      fi; \
    fi; \
    \
    # Build the Chef package name and download URL
    chef_package="chef_${CHEF_VERSION}-1_${chef_arch}.deb"; \
    chef_url="https://packages.chef.io/files/stable/chef/${CHEF_VERSION}/${chef_platform}/${os_release}/${chef_package}"; \
    \
    # Download and install the .deb
    echo "Downloading Chef from $chef_url"; \
    wget --no-verbose -O "/tmp/${chef_package}" "${chef_url}"; \
    apt-get install -y --no-install-recommends "/tmp/${chef_package}"; \
    \
    # Cleanup
    rm -f "/tmp/${chef_package}"; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

# check chef-client and bundle ruby are functional
# hadolint ignore=DL3059
RUN ["/opt/chef/bin/chef-client", "--version"]
# hadolint ignore=DL3059
RUN ["/opt/chef/bin/ruby", "--version"]

VOLUME ["/opt/chef"]
