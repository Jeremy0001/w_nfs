require 'chefspec'
require 'chefspec/berkshelf'
require 'mymatchers'

ChefSpec::Coverage.start! do
  add_filter(%r{/nfs/})
end

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
  config.filter_run_excluding skip: true
end