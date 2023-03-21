VERSION = `git rev-parse --short HEAD`
REGISTRY ?= ghcr.io/haiku

default:
	docker build -t ${REGISTRY}/website-gemini:${VERSION} .
push:
	docker push ${REGISTRY}/website-gemini:${VERSION}
	@echo "${REGISTRY}/website-gemini:${VERSION} has been pushed!"
test:
	docker kill website-gemini-test || true
	docker rm website-gemini-test || true
	docker run --name website-gemini-test -p 1965:1965 ${REGISTRY}/website-gemini:${VERSION}
clean:
	docker kill website-gemini-test || true
	docker rm website-gemini-test || true
