# Auth0 AD/LDAP Connector Image
FROM node
ENV CONNECTOR_VERSION=v6.1.0
RUN apt-get update && apt-get install -y curl
RUN curl -Lo /tmp/adldap.tar.gz https://github.com/auth0/ad-ldap-connector/archive/${CONNECTOR_VERSION}.tar.gz
RUN mkdir /opt/auth0-adldap && tar -xzf /tmp/adldap.tar.gz -C /opt/auth0-adldap --strip-components=1
RUN cd /opt/auth0-adldap && npm install
WORKDIR /opt/auth0-adldap
CMD bash -c "node server.js && node admin/server.js"
EXPOSE 8357

