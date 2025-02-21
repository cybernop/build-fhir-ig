# Build FHIR IG

[![Docker Images](https://github.com/cybernop/build-fhir-ig/actions/workflows/docker-images.yaml/badge.svg)](https://github.com/cybernop/build-fhir-ig/actions/workflows/docker-images.yaml)

This repository presents a github action and a Docker image to build FHIR IGs from a FSH Sushi project.

## Docker

A FHIR IG can be build using the script `docker/scripts/build-fhir-ig.sh` and create an archive containing the complete FHIR IG.

```bash
[IGPUB_VERSION=<ig publisher version>] [SUSHI_VERSION=<sushi version>] [OUTPUT_DIR=<output directory>] [PROJECT_DIR=<project directory>] docker/scripts/build-fhir-ig.sh
```

All arguments in braces are optional.

Without any arguments, IG Publisher version `1.8.8` expects the current directory to be the FSH Sushi project directory and expects the FSH Sushi output in the `fsh-generated/` subdirectory. The archive is placed in a `output/` subdirectory.

A different version of IG Publisher can be used for the build with `IGPUB_VERSION=<ig publisher version>`. If the FSH Sushi output is not already generated on the system or if it should be ensured that the generated files match the result of a fixed Sushi version `SUSHI_VERSION=<sushi version>` can be used.

Output and project directory can be modified with `OUTPUT_DIR=<output directory>` and `PROJECT_DIR=<project directory>` respectivly.

Alternatively, one can directly use the Docker image

```bash
docker run --rm -v <project directory>:/project [-v <fhir cache>/packages:/root/.fhir/packages] -v <output directory>:/output cybernop/build-fhir-ig:<tag>
```

with the the FSH Sushi project directory `<project directory>` and the output directory `<output directory>`. If the local FHIR cache should be used, it can be mounted by mounting `<fhir cache>`.

The `<tag>` build like `<ig publisher version>[-sushi-<sushi version>]`, specifying the version of IG Publisher to be used and optionally the FSH Sushi version if it should executed during the build.
