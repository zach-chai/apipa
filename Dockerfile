FROM apipa_base:latest

ENV RACK_ENV=production

# Install dependencies
COPY Gemfile* ${APP_HOME}/
RUN bundle install --deployment --without=development test

# Add code
ADD . ${APP_HOME}

CMD [ "bundle", "exec", "rackup" ]
