FROM ruby:2.7

ENV ACTION_PATH /action

RUN mkdir -p $ACTION_PATH
RUN gem install bundler

COPY . $ACTION_PATH

RUN cd $ACTION_PATH && bundle install

ENTRYPOINT ["/action/entrypoint.sh"]
