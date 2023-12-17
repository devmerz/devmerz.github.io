FROM ruby:2.7

WORKDIR /usr/src/app

COPY . .

RUN bundle install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
