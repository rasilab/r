FROM ghcr.io/rasilab/r:1.3.0

## Install ggtree
RUN mamba install -c conda-forge -c bioconda bioconductor-ggtree==3.10.0
