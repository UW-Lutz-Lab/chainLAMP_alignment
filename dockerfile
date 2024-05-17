# FROM nextflow/nextflow

# RUN yum install -y python3 python3-pip && \
#     yum clean all

FROM nextflow/nextflow

# Install Python and pip
RUN yum install -y python3 python3-pip && \
    yum clean all

# Install wget for downloading files (if not already included in your base image)
RUN yum install -y wget && \
    yum clean all

# Download and extract Dorado
# RUN wget https://cdn.oxfordnanoportal.com/software/analysis/dorado-0.6.1-linux-arm64.tar.gz -O /tmp/dorado.tar.gz && \
#     tar -xzvf /tmp/dorado.tar.gz -C /opt/ && \
#     rm /tmp/dorado.tar.gz

RUN curl -L https://cdn.oxfordnanoportal.com/software/analysis/dorado-0.6.1-linux-arm64.tar.gz -o /tmp/dorado.tar.gz && \
    tar -xzvf /tmp/dorado.tar.gz -C /opt/ && \
    rm /tmp/dorado.tar.gz

# Optionally, add the Dorado executable to the PATH if it's not globally accessible
ENV PATH="/opt/dorado-0.6.1-linux-arm64:$PATH"
