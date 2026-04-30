# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'httparty'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'propshaft'
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.1.3'
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'dotenv-rails'

group :development, :test do
  gem 'amazing_print'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'rubocop-rails-omakase', require: false
end

group :development do
  gem 'annotaterb'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'ordinare', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'resque_spec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webmock'
end
