# [deltaflare Ltd] ("COMPANY") CONFIDENTIAL
# Unpublished Copyright © 2022 [deltaflare Ltd], All Rights Reserved.

# NOTICE: All information contained herein is, and remains the property of
# COMPANY. The intellectual and technical concepts contained herein are
# proprietary to COMPANY and may be covered by U.S. and Foreign Patents, patents
# in process, and are protected by trade secret or copyright law. Dissemination
# of this information or reproduction of this material is strictly forbidden
# unless prior written permission is obtained from COMPANY. Access to the source
# code contained herein is hereby forbidden to anyone except current COMPANY
# employees, managers or contractors who have executed Confidentiality and
# Non-disclosure agreements explicitly covering such access.

# The copyright notice above does not evidence any actual or intended publication
# or disclosure of this source code, which includes information that is
# confidential and/or proprietary, and is a trade secret, of COMPANY. ANY
# REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC PERFORMANCE, OR PUBLIC DISPLAY
# OF OR THROUGH USE OF THIS SOURCE CODE WITHOUT THE EXPRESS WRITTEN CONSENT
# OF COMPANY IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE LAWS AND
# INTERNATIONAL TREATIES. THE RECEIPT OR POSSESSION OF THIS SOURCE CODE AND/OR
# RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS TO REPRODUCE, DISCLOSE
# OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT
# MAY DESCRIBE, IN WHOLE OR IN PART.

DOCKER=docker
GIT=git
GO=go

# Getting variables from the .build file
REGISTRY := $(shell grep REGISTRY .build | cut -d '=' -f2)
CONTAINER_PREFIX := $(shell grep CONTAINER_PREFIX .build | cut -d '=' -f2)
ORG := $(shell grep ORG .build | cut -d '=' -f2)
SERVICE := $(shell grep SERVICE .build | cut -d '=' -f2)

CGO_ENABLED ?= 0
GOARCH ?= amd64
# for a release, use the latest git tag
VERSION ?= $(shell git describe --abbrev=0 --tags)

# For general every day, use the git
COMMIT ?= 29112023 #$(shell git rev-parse HEAD)
TIME = $(shell date +%F-T%H_%M)

.PHONY:build push release

build: 
	$(DOCKER) build -t $(REGISTRY)/$(ORG)/$(CONTAINER_PREFIX)-$(SERVICE):$(COMMIT) -f Dockerfile .

# This is a dev push
push: build
	$(DOCKER) push $(REGISTRY)/$(ORG)/$(CONTAINER_PREFIX)-$(SERVICE):$(COMMIT)

# Only use this when a tag has been created and the code is to be released
release: 
		$(GIT) checkout ${VERSION}
		$(DOCKER) build -t $(REGISTRY)/$(ORG)/$(CONTAINER_PREFIX)-$(SERVICE):$(VERSION) -f Dockerfile .
		$(DOCKER) push $(REGISTRY)/$(ORG)/$(CONTAINER_PREFIX)-$(SERVICE):$(VERSION)

	

