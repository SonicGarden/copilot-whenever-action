FROM ruby:2.7

ENV ACTION_PATH /action

RUN gem install bundler
RUN mkdir -p $ACTION_PATH

COPY . $ACTION_PATH

RUN cd $ACTION_PATH && bundle install

ENTRYPOINT ["/action/entrypoint.sh"]
