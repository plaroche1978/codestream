FROM photon:3.0
LABEL maintainer="plaroche@vmware.com"

ENV PYTHON_VERSION=python3-3.7.5-9.ph3
ENV PIP_VERSION=python3-pip-3.7.5-9.ph3
ENV IDEM_VERSION=15.0.0
ENV IDEM_AZURE_AUTO_VERSION=0.0.3
ADD ca-trust /tmp/

RUN tdnf install ${PYTHON_VERSION} ${PIP_VERSION} -y && \
        python3 -m venv idem && \
        source idem/bin/activate && \
        pip3 install --upgrade pip && \
        pip3 install --upgrade setuptools && \
        pip3 install idem && \
        pip3 install idem-aws && \
        pip3 install idem-azure-auto

ENV PATH="/idem/bin:$PATH"

RUN yum -y install curl wget unzip git ca-certificates openssl jq && \
    cat /tmp/vmware-issue.crt >> /etc/pki/tls/certs/ca-bundle.crt && \
    cat /tmp/vmware-root.crt >> /etc/pki/tls/certs/ca-bundle.crt

# ENTRYPOINT [ "idem" ]