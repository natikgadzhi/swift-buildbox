# Swift for ARM Buildbox

The Swift for ARM Buildbox provides a Docker image you can use to cross-compile
your Swift projects for ARM targets. It currently supports `armv7` and
`aarch64`.

The buildbox uses Swift for ARM from the Community Swift for ARM repository.

## Usage

```bash
docker run swift-buildbox-aarch64:latest -v ./src:/src swift build
```
