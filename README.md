# chainLAMP_alignment_pipeline

__Docker desktop is required to be installed and running while attempting to run this pipeline__

- 1. Copy or download the docker file to a file called `dockerfile` or `Dockerfile` with _no_ file extension.

- 2. Navigate to directory with docker file then the command

```
docker build -t <DOCKER_CONTAINER_NAME> .
```

DOCKER_CONTAINER_NAME can be replace by a name of your choosing, but must not contain capital letters, spaces, or be named dockerfile/Dockerfile; a good choice might be `chainlamp_pipeline`

- 3. Once the image has been built, the pipeline can be run

- 4. Navigate to the directory where the unaligned bam file(s) are located in terminal

- 5. Make a directory called `processed_results` with the command

```
mkdir processed_results
```

- 6. Run the pipeline!

#### Single-Bam Mode

```
docker run -it -v "${PWD}:/mnt" chainlamp_pipeline nextflow run mcgrupp3/chainLAMP_alignment_pipeline \
    --reads "${BAM_FILE}" \
    --outdir "./processed_results/${BASENAME}/" \
    -r "main"
```

#### Multi-Bam Mode

Coming Soon!
