# Build Script (using Docker)

This script handles the arguments and starts the correct Docker image. Call it with

```bash
. ./build-fhir-ig.sh <project dir>
```

with `<project dir>` as the FSH Sushi project root directory. Without this argument the current directory is used.

Other arguments can be passed as variables:

| Variable | Description | Default |
| --- | --- | --- |
| `SUSHI_VERSION` |  If provided, IG Publisher will run Sushi with this version during build | `None` |
| `IGPUB_VERSION` | Version of IG Publisher to be used | `1.8.8` |
| `OUTPUT_DIR` | Directory to place the generated IG archive and logs | `$PWD/output` |
| `PUBLISH_URL` | If provided the IG will be marked as publish version with this URL | `None` |
| `JAVA_OPTS` | Custom Java options can be provided here | `-Xmx2g` |

**Remarks**: If Sushi build takes a long time, a custom timeout can be provided by placing a file named `fsh.ini` in the project root with the following contents:

```ini
[FSH]
timeout = <timeout in s>
```
