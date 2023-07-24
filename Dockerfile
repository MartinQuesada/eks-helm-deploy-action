FROM public.ecr.aws/docker/library/python:3.9.13-slim-buster

ARG KUBECTL_VERSION=1.22.12
# Install the toolset.
RUN apt -y update && apt -y install curl git \
    && pip install awscli \
    && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
    
COPY deploy.sh /usr/local/bin/deploy

CMD deploy