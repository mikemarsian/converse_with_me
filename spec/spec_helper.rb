require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'pry'
require 'converse_with_me'


RSpec.configure do |config|

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.mock_with :rspec

end


# **** add helper methods here ***