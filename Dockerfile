# syntax=docker/dockerfile:experimental
ARG DOCKER_URL
ARG DOCKER_ORG

ARG PROJECT_NAME=alpha-dynamodb-svc
FROM ${DOCKER_URL}/${DOCKER_ORG}/ansible-img:b88
