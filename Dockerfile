from ruby:slim-buster

WORKDIR /bc_app
ARG PORT
ARG HOST
#Install dependencies
ADD Gemfile /bc_app
RUN bundle install

EXPOSE $PORT
ADD server.rb /bc_app
ADD blockchain.rb /bc_app

CMD ruby server.rb $PORT $HOST