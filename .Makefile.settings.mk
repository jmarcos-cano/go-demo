SHELL=/bin/bash -e -o pipefail

# Docker build-args
export GIT_REPO ?= $(shell git config --get remote.origin.url )
export GIT_BRANCH ?= $(shell git branch|cut -d" " -f 2 )

export GIT_COMMIT ?= $(shell git rev-parse --short HEAD)
export GIT_COMMIT_DETAILS ?= $(shell git log -1 --pretty=oneline )
#export BUILD_DATE := $(shell date --rfc-3339=seconds )
export BUILD_DATE :=$(shell date "+%Y-%m-%d %H:%M:%S")
export BUILD_TAG ?= $(shell hostname)


.DEFAULT_GOAL := all

# Cosmetics
RED := "\e[1;31m"
YELLOW := "\e[1;33m"
NC := "\e[0m"
INFO := @bash -c 'printf $(YELLOW); printf "=> $$1 \n"; printf $(NC)' MESSAGE
WARNING := @bash -c 'printf $(RED); printf "WARNING: $$1 \n"; printf $(NC)' MESSAGE

## Meta
metadata_file=.metadata
metadata= "Docker image was created  \n\
      IMAGE: $(IMAGE):$(VERSION) \n\
      BUILD_DATE: $(BUILD_DATE) \n\
      GIT_REPO: $(GIT_REPO) \n\
      GIT_COMMIT: $(GIT_COMMIT) \n\
      GIT_BRANCH: $(GIT_BRANCH)  \n\
      BUILD_TAG: $(BUILD_TAG) \n\
      "

label: ## prints out label-schema metadata
	@ ${INFO} ${metadata}
	@printf ${metadata} > ${metadata_file}


help: ## prints this help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

