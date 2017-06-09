FROM alpine:3.4
MAINTAINER 	Viktor Farcic <viktor@farcic.com>

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2


ENV APP_HOME=/var/www/app DB=db
WORKDIR ${APP_HOME}
ARG BIN_PATH 
ADD ${BIN_PATH} ./
RUN chmod -R +x  ${BIN_PATH}


EXPOSE 8080

CMD ["./go-demo"]
HEALTHCHECK --interval=10s CMD wget -qO- localhost:8080/demo/hello



### METADATA
ARG IMAGE
ARG VERSION=0.0.0
ARG GIT_REPO
ARG GIT_COMMIT=123 
ARG GIT_BRANCH=master
ARG BUILD_DATE
ARG BUILD_TAG


LABEL maintainer="<jmarcos.cano@gmail.com>"  \
      org.label-schema.org="${IMAGE}" \
      org.label-schema.description="simple go demo app" \
	  org.label-schema.name="${IMAGE}" \
	  org.label-schema.version="${VERSION}" \
      org.label-schema.vcs-ref="${GIT_COMMIT}" \
      org.label-schema.vcs-url="${GIT_REPO}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.build-id="${BUILD_TAG}"