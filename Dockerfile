# base conda container
FROM continuumio/miniconda3:4.12.0

# for writing in Helvetica font
COPY Helvetica.tgz /tmp/Helvetica.tgz 
RUN tar -xvzf /tmp/Helvetica.tgz && \
    mkdir -p /usr/share/fonts/truetype/Helvetica && \
    mv Helvetica*.ttf /usr/share/fonts/truetype/Helvetica/

# Install mamba installer for quick conda installations
RUN conda install mamba -c conda-forge

# Install Python packages in base environment 
RUN mamba install -y -c conda-forge jupyter 

# Install R conda environment
RUN mamba create -y -n R

RUN mamba install -y -n R -c conda-forge \
    r-tidyverse \
    r-janitor \
    r-irkernel \
    r-glue \
    r-devtools \
    r-plotrix \
    r-r.utils \
    r-ggrepel \
    r-ggthemes \
    r-ggridges \
    r-ggpubr 

RUN mamba install -y -n R -c bioconda -c conda-forge \
  bioconductor-plyranges \
  bioconductor-flowcore \
  bioconductor-bsgenome.hsapiens.ucsc.hg19 \
  bioconductor-bsgenome.hsapiens.ucsc.hg38 \
  bioconductor-ggbio 

# Set up R jupyter kernel and make it visible to python
RUN /opt/conda/envs/R/bin/R -s -e "IRkernel::installspec(sys_prefix = T)"

# Make R visible to python environment
ENV PATH="$PATH:/opt/conda/envs/R/bin"

# install rasilab R templates
RUN /opt/conda/envs/R/bin/R -s -e "devtools::install_github('rasilab/rasilabRtemplates', ref = '0.4.0')"

# for rasterizing specific ggplot layers
RUN mamba install -c conda-forge r-ggrastr r-ggh4x