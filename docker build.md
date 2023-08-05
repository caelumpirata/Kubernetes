# Command to build image which works on multiple arch edge (ubuntu based)
build + push 
```
# First, ensure you have Docker Buildx set up and activated:
docker buildx create --use

# Tag the image with platform-specific tags and push it to Docker Hub
docker buildx build --platform linux/amd64,linux/arm64 -t savantripathi22/edge:multi_support_v1 --push .

```
