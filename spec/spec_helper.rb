require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'pry'
require 'webmock/rspec'
require 'converse_with_me'

RSpec.configure do |config|

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.mock_with :rspec

end

# include template files
Dir[File.dirname(__FILE__) + "/templates/*.erb"].sort.each { |f| require File.expand_path(f) }

# **** add helper methods here ***