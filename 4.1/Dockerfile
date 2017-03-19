FROM glassfish/openjdk 

# Maintainer
MAINTAINER Koral.co

RUN mkdir /docker-entrypoint-glassfish.d

ENV GLASSFISH_PKG=glassfish-4.1.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/4.1/release/glassfish-4.1.zip \
    GLASSFISH_HOME=/glassfish4 \
    PATH=$PATH:/glassfish4/bin \
    PASSWORD=glassfish

RUN apk add --update wget unzip bash su-exec && \
    wget --no-check-certificate $GLASSFISH_URL && \
    unzip -o $GLASSFISH_PKG && \
    rm -f $GLASSFISH_PKG && \
    echo "--- Setup the password file ---" && \
    echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd && \
    echo "AS_ADMIN_NEWPASSWORD=${PASSWORD}" >> /tmp/glassfishpwd  && \
    echo "--- Enable DAS, change admin password, and secure admin access ---" && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1 && \
    asadmin start-domain && \
    echo "AS_ADMIN_PASSWORD=${PASSWORD}" > /tmp/glassfishpwd && \
    wget --no-check-certificate http://jdbc.postgresql.org/download/postgresql-42.0.0.jar -O $GLASSFISH_HOME/glassfish/lib/postgres-42.0.0.jar && \
    apk del wget unzip && \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin && \
    asadmin --user=admin stop-domain && \
    rm /tmp/glassfishpwd

COPY glassfish-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/glassfish-entrypoint.sh

EXPOSE 4848 8080 8181

ENTRYPOINT ["glassfish-entrypoint.sh"]
CMD ["glassfish"]
