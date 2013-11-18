# coding: utf-8
require(File.dirname(__FILE__)+"/../lib/wikipedia_parser.rb")

describe WikiParser do
	before(:each) do
		@parse = WikiParser.new :path => File.dirname(__FILE__)+"/test_dump.xml"
	end

	it 'should only obtain the title when provided with that stopping point' do
		pages = []
		3.times do |i|
			page = @parse.get_next_page :until => "title"
			pages << page
		end
		pages.should have(3).items
		pages.each do |page|
			page.internal_links.should be_empty
		end
	end

end