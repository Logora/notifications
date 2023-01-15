source "https://rubygems.org"

gemspec

gem 'rails', '~> 6.1.7'
gem 'puma', '~> 5.6.4'
gem 'pg', '~> 1.4.5'
gem 'pagy', '~> 4.11.0'
gem 'plucker_serializer', '~> 0.5.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'unicode', platforms: [:ruby]
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'turbo_tests'
end

group :test do
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'rails-controller-testing'
  gem 'wisper-rspec'
  gem 'wisper-testing'
  gem 'simplecov'
end