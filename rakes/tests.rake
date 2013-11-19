require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |t|
	t.pattern = 'tests/*.rb'
	t.rspec_opts = '--color --format s'
end