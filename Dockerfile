FROM ghcr.io/rasilab/r:1.1.0

# include for svg export from ggplot2
RUN mamba install -y -n R -c conda-forge r-svglite
