Gem::Specification.new do |s|
  s.name        = 'wikipedia_parser'
  s.version     = '1.0.0'
  s.date        = '2013-11-08'
  s.summary     = "Parse Wikipedia dumps, extract links, and page types."
  s.description = "Parse Wikipedia dumps in compressed on uncompressed form, extract links, and page types."
  s.authors     = ["Jonathan Raiman"]
  s.email       = 'jraiman@mit.edu'
  s.files       = ["lib/wikipedia_parser.rb", "lib/wikiParser.rb", "lib/wikiParserPage.rb", "README.md"]
  s.requirements << "nokogiri"
  s.requirements << "bzip2"
  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'bzip2'
  s.homepage    = 'http://github.org/JonathanRaiman/wikipedia_parser'
  s.license     = 'MIT'
  s.has_rdoc = 'yard'
end