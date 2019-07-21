# URL Shortener Service in AWS Serverless

This repository is an example for creating URL shortener service with AWS API Gateway and Lambda

## Setup

```bash
$ npm install -g serverless
$ npm install
$ bundle
$ sls deploy
```

## Testing API

```bash
curl -d '{"longUrl":"https://example.com"}' https://{api}.execute-api.{region}.amazonaws.com/url/shortener
```
