# Docker

A Docker Image to build a FHIR IG from a FSH Sushi project using IG publisher.

```bash
docker run --rm
    -v <project directory>:/project
    [-v <fhir cache>/packages:/root/.fhir/packages]
    -v <output directory>:/output
    [-e IGPUB_VERSION=<ig pub version>]
    [-e SUSHI_VERSION=<sushi version>]
    [-e PUBLISH_URL=<publish url>]
    [-e _JAVA_OPTIONS=<java opts>]
    cybernop/build-fhir-ig:<tag>
```

with the the FSH Sushi project directory `<project directory>` and the output directory `<output directory>`. If the local FHIR cache should be used, it can be mounted by mounting `<fhir cache>`.

Optionally, the version of IG Publisher and FSH Sushi can be provided with the environment variables `IGPUB_VERSION=<ig pub version>` respectivly `SUSHI_VERSION=<sushi version>`. If the version of IG Publisher is not provided, the latest one is used. Without a version of FSH Sushi it will not be run during the build and the existing generated files used from `<project directory>/fsh-generated`.

By setting setting `PUBLISH_URL=<publish url>` the generated IG will be marked as publish version and this URL will be set.

The behaviour of the Java VM can be modified with `_JAVA_OPTIONS=<java opts>`. This may be needed if the project has large files and IG Publisher needs more memory. To increase the memory for JVM set `_JAVA_OPTIONS=-Xmx<size>`.

The following tags are available (to run Sushi the ones with NPM are needed):

* Ubuntu: `flex`, `flex-ubuntu`
* Ubuntu + NPM: `flex-npm`, `flex-npm-ubuntu`
* Alpine: `flex-alpine`
* Alpine + NPM: `flex-npm-alpine`

There is also a script available to handle the arguments and running the Docker image, [see `scripts/`](scripts/README.md)
