# Swift for ARM Buildbox

Build and test Swift apps for Raspberry Pi (and other ARM64 / aarch64 computers)
on a Mac or Windows with the swift-builbox docker image!

Swift Buildbox provides Docker images in multiple architectures with different
Swift runtimes that can compile and test your projects, without installing Swift
on the target machine itself.

The buildbox uses Swift for ARM from the
[Community Swift for ARM repository](https://packagecloud.io/swift-arm/release).

## Usage

### `swift build`

```bash
docker run xnutsive/swift-buildbox:arm64-5.2.5-6 -it -v $(pwd):/home/build-user/project swift build
```

This should download the Docker image and run `swift build` for the current
directory. The resulting binaries will be stored in the `.build` directory as
usual.

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

### Known issues

The `armhf` version currently doesn't work, but that's just a problem of making
sure that the repo has a certain Swift runtime package, taking it's name, and
making sure the `Makefile` sets the right env variables.
