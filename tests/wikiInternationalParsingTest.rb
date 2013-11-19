#coding: utf-8

require(File.dirname(__FILE__)+"/../lib/wikipedia_parser.rb")

describe 'WikiParser in other languages' do
	before(:all) do
		@parse = WikiParser.new :path => File.dirname(__FILE__)+"/test_russian_dump.xml"
		@language = "ru"
		@page = @parse.get_next_page
	end

	it 'should obtain the language of the dump it is parsing' do
		@parse.language.should eql @language
		@page.language.should eql @language
	end

	it 'should have localized internal links' do
		@page.internal_links.each do |link|
			link[:title][@language.to_sym].should_not be_nil
		end
	end
end