# Swift Buildbox Makefile
#
# This file is used to build swift buildbox docker images and upload them.
# It's not useful for compiling your swift code itself.

# Supported architectures: arm64, armv7
ARCH ?= arm64
RUNTIME := 5.2.5-6 # add more runtimes, 5.3 is available
PLATFORM := linux
BASE_NAME := xnutsive/swift-buildbox

# Substitution makes tag valid for arm/v7 architecture.
BBOX := $(BASE_NAME):$(subst /,,$(ARCH))-$(RUNTIME)

# Perform build operation, expects $ARCH to be set to a specific architecture
.PHONY: build
build:
	docker buildx build -t $(BBOX) --platform $(PLATFORM)/$(ARCH) --load .

# Upload Docker images to Docker Hub
.PHONY: push
push:
	docker push $(BBOX)
