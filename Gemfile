source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem 'sqlite3'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'bootsnap'
gem 'sorcery'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # 2026.3/10 by kino
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :test do
  # 2026.3/13 by kino software test chapture8
  gem 'capybara'
  gem 'selenium-webdriver'
  gem "webdrivers"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'rubocop'
  gem 'rails_best_practices'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
