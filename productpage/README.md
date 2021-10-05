# How to run product page

## Prerequisite

* Python 3.8

```bash
pip install -r requirements.txt
python productpage.py 9080
```

## How to run with Docker
```bash
# Build Docker Image for productpage service
docker build -t productpage .

# Run productpage service on port 8083
docker run -d --name productpage -p 8083:9080 productpage
```