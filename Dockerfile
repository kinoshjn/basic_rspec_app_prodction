FROM ruby:3.1.4
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Node.js 22.x (LTS) のインストール
RUN apt-get update -qq \
  && apt-get install -y ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && apt-get update -qq \
  && apt-get install -y build-essential libpq-dev nodejs \
  && npm install -g yarn@1.22.22
RUN mkdir /sample_app_for_rspec
WORKDIR /sample_app_for_rspec
RUN gem install bundler:2.3.17
COPY Gemfile /sample_app_for_rspec/Gemfile
COPY Gemfile.lock /sample_app_for_rspec/Gemfile.lock
COPY yarn.lock /sample_app_for_rspec/yarn.lock
RUN bundle install
RUN yarn install
COPY . /sample_app_for_rspec
