SWIFT ?= 5.2.5
ARCH ?= arm64

build-mac:
	swift build

clean:
	rm -rf .build

build:
	docker run xnutsive/swift-buildbox:$(SWIFT)-$(ARCH) -v $(pwd):$(pwd) -w $(pwd) swift build
