VERSION = `git rev-parse --short HEAD`
REGISTRY ?= ghcr.io/haiku
ENGINE ?= podman

default:
	${ENGINE} build -t ${REGISTRY}/website-gemini:${VERSION} .
push:
	${ENGINE} push ${REGISTRY}/website-gemini:${VERSION}
	@echo "${REGISTRY}/website-gemini:${VERSION} has been pushed!"
test:
	${ENGINE} kill website-gemini-test || true
	${ENGINE} rm website-gemini-test || true
	${ENGINE} run --name website-gemini-test -p 1965:1965 ${REGISTRY}/website-gemini:${VERSION}
clean:
	${ENGINE} kill website-gemini-test || true
	${ENGINE} rm website-gemini-test || true
