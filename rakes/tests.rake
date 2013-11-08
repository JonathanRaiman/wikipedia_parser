require 'rake'
require 'rspec/core/rake_task'

namespace :test do
	RSpec::Core::RakeTask.new(:all) do |t|
		t.pattern = 'tests/*.rb'
		t.rspec_opts = '--color --format s'
	end
end