FROM ruby:2.7

ENV ACTION_PATH /action

RUN mkdir -p $ACTION_PATH
RUN gem install bundler

COPY Gemfile $ACTION_PATH/.
COPY Gemfile.lock $ACTION_PATH/.
COPY exec_elastic_whenever.rb $ACTION_PATH/.

RUN cd $ACTION_PATH && bundle install

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
