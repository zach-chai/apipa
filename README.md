# APIPA

API for checking Palindrome of Strings

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
Deploy app
```
docker-compose build
heroku container:push web
heroku container:release web
```
