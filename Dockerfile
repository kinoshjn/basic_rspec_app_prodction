FROM ruby:3.1.4
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /sample_app_for_rspec
WORKDIR /sample_app_for_rspec
RUN gem install bundler:2.3.17
COPY Gemfile /sample_app_for_rspec/Gemfile
COPY Gemfile.lock /sample_app_for_rspec/Gemfile.lock
COPY yarn.lock /sample_app_for_rspec/yarn.lock
RUN bundle install
RUN yarn install
COPY . /sample_app_for_rspec
