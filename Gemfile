source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'


gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
# gem 'rack-cors'
gem 'rails', '~> 5.1.4'
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem "factory_bot_rails", "~> 4.0"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
  gem 'coveralls', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
