Gem::Specification.new do |s|
  s.name        = 'wikipedia_parser'
  s.version     = '1.0.5'
  s.date        = '2013-11-18'
  s.summary     = "Parse Wikipedia dumps, extract links, and page types."
  s.description = "Parse Wikipedia dumps in compressed on uncompressed form, extract links, and page types."
  s.authors     = ["Jonathan Raiman"]
  s.email       = 'jraiman@mit.edu'
  s.files       = ["README.md"]
  s.files       = Dir['lib/*.rb']
  s.files       += Dir['test/*']
  s.requirements << "nokogiri"
  s.add_runtime_dependency 'nokogiri'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.homepage    = 'http://github.org/JonathanRaiman/wikipedia_parser'
  s.license     = 'MIT'
  s.has_rdoc    = 'yard'
end