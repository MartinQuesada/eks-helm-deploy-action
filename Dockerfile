FROM python:3.9.23-slim-bookworm

ARG KUBECTL_VERSION=1.34.0

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ca-certificates \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install awscli
RUN pip install --no-cache-dir awscli

# Install Helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

# Clean up build dependencies
RUN apt-get purge -y gcc g++ make && apt-get autoremove -y
    
COPY deploy.sh /usr/local/bin/deploy

CMD ["deploy"]
