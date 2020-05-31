FROM python:3.6-alpine
LABEL Name="Python Example"
LABEL Build_Date="2020-05-30"
LABEL Version="0.1"

USER 0

COPY . /code

WORKDIR /code

# Configure the python environment
RUN ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime && \
    pip install --cert ./pypi.pem -r requirements.txt && \
    rm -rf /root/.cache/pip && \
    groupadd -g 1001 default && \
    useradd -u 1001 -g 1001 default -m && \
    chmod -R 775 /code && \
    chown -R default:default /code

COPY ca.pem /usr/share/ca-certificates/

RUN cat /usr/share/ca-certificates/ca.pem >> /usr/lib/python3.6/site-packages/certificates/cacert.pem && \
    update-ca-certificates

# Using tini for PID 1
# Add Tini (https://github.com/krallin/tini)
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

USER 1001

ENTRYPOINT ["/tini", "--"]

# run the python application
CMD ["python", "example.py"]
