# Compile Swift apps for ARM / Raspberry Pi on your mac

Swift Builbox is a Swift toolchain wrapper, available as a docker image.

Assuming you're in the Swift project directory:

```bash
docker run xnutsive/swift-buildbox:5.2.5-arm64 -it -v $(pwd):$(pwd) -w $(pwd) swift build
```

This should download the Docker image and run `swift build` for the current
directory. The resulting binaries will be stored in the `.build` directory as
usual.

## Supported architectures

Use `xnutsive/swift-buildbox:5.1.5-armhf` if you want to run your apps in Raspbian, or
`xnutsive/swift-builbox:5.2.5-arm64` if you installed an arm64 OS on your Pi.

### Gotchas and static linking

If you want to build an app that you'd run on a Raspberry that doesn't have
Swift installed, there are a few gotchas:

First off, currently, only `arm64` aka `aarch64` is supported. Meaning that if
you're running Ubuntu 20.04 on the Pi, you're probably fine, but the buildbox
currently can't build binaries for Rasbian Buster.

If the plan is to build binaries that don't require Swift stdlib installed, then
you'd want to link it statically. To do that, you'd want to run
`swift build -c release --static-swift-stdlib -Xswiftc -static-stdlib`. Note
that the binary size will be hube: a simple hello world example binary is 34M.
