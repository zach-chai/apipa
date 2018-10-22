# APIPA

An API for storing messages and checking if they are palindromes. Create, read, and delete operations supported.

## Project Description

This is a Rack-compatible application written in Ruby with Sinatra, and uses Redis for persistent storage. It uses the Thin as the web server but its drop-in replaceable. The project is also compatible with Docker for development and production.

![Architecture Diagram](https://gist.githubusercontent.com/zach-chai/aa0b1aa7121cdbe175e8ccc0705f56c5/raw/05e5dcea4c0d3eb64cc85b38b827c8cb0fa68070/app_architecture.jpg)

## API Documentation

The API documentation uses Open API Specification.

You can view the [docs here](https://petstore.swagger.io/?url=https://palindrome-service.herokuapp.com/spec.yaml)

## Development Setup
Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

Clone repo
```bash
git clone git@github.com:zach-chai/apipa.git
```
Install app dependencies
```bash
docker-compose run --rm app bundle install
```
Start app server and Redis
```bash
docker-compose up -d
```
It should now be running at http://localhost:4567/

## Testing

This project uses Minitest framework for testing

Use the command below to run the tests:
```bash
docker-compose run --rm app rake test
```
After running the tests, coverage information is generated at `coverage/index.html`

Linting is also available:
```bash
docker-compose run --rm app rubocop
```

## Cloud Deployment - Heroku

### Setup
First create a Heroku account and Heroku app.

Then add 'heroku-redis' addon to the Heroku app

### Deploy
Install Heroku CLI, then setup with following commands.
```bash
heroku login
heroku git:remote --app <heroku_app>
```
Build and deploy app
```bash
docker-compose build
heroku container:push web
heroku container:release web
```
For subsequent deploys just run the last 3 commands.

Optional: set the `PUBLIC_URL` env variable to address of the app
