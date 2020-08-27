# Swift Buildbox Makefile
#
# This file is used to build swift buildbox docker images and upload them.
# It's not useful for compiling your swift code itself.

# What platform are we building for?
# The current Dockerfile only supports Linux + ARM.
PLATFORM ?= linux

# What Ubuntu version to use in the image?
# Ubuntu 18.04 xenial has Swift packages built for
# both arm/v7 and arm64, that's a sane default.
#
# If you change this and rebuild the images, make sure to also change
# the $RUNTIME
BASE_IMAGE ?= ubuntu:18.04

# Supported architectures:
# The arch is passed to docker buildx. It's not a DEB package architecture,
# so it uses arm/v7 instead of armhf.
#
# Possible values:
# 	- arm64
# 	- arm/v7
#
# Target linux system arch (i.e. armhf for arm/v7) is inferred automatically.
DOCKER_ARCH ?= arm64
TARGET_ARCH := $(subst /v7,hf,$(DOCKER_ARCH))


# The section below assembles the right Swift package name to install.
#
# Swift debianpackage name.
#
# Possible values:
# 	- swift-lang for 5.2+ on arm64
# 	- swift5 for earlier swift versions on arm/v7
SWIFT_DEB ?= swift-lang

# Swift language version — used in the deb package name,
# and also in the $BBOX (buildbox image tag).
#
SWIFT_VERSION ?= 5.2.5

# Debian package suffix, for the list of suffixes available,
# check out https://packagecloud.io/app/swift-arm/release/
#
SWIFT_DEB_SUFFIX ?= 11-ubuntu-bionic

SWIFT ?= $(SWIFT_DEB)=$(SWIFT_VERSION)-$(SWIFT_DEB_SUFFIX)

# That's the base part of the Docker image name to tag.
# If you're building your own toolchain, you will probably want to change that.
IMAGE ?= xnutsive/swift-buildbox

# Substitution makes tag valid for arm/v7 architecture.
BBOX ?= $(IMAGE):$(SWIFT_VERSION)-$(TARGET_ARCH)

# Builds the docker image with the toolchain.
# The default env variable values above are for the arm64 build.
#
# To build the toolchain for armhf, try the following:
#
.PHONY: build
build:
	docker buildx build -t $(BBOX) --platform $(PLATFORM)/$(DOCKER_ARCH) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg SWIFT=$(SWIFT) \
		--load .

# Upload Docker images to Docker Hub
.PHONY: push
push:
	docker push $(BBOX)
