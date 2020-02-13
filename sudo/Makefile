build:
	docker build -t drewsortega/challengestest .
run:
	docker run -d -P drewsortega/challengestest:latest | xargs -I % docker port % 22
