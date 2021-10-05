# itkmitl-bookinfo-reviews

## How to run with Docker
```bash
# Build Docker Image for review service
docker build -t reviews .

# Run review service on port 8082
docker run -d --name reviews -p 8082:9080 reviews
```
