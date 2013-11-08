#coding: utf-8

require(File.dirname(__FILE__)+"/../lib/wikipedia_parser.rb")

describe WikiParser do
	before(:each) do
		@parse = WikiParser.new :path => File.dirname(__FILE__)+"/test_dump.xml"
	end

	it 'should obtain the 3 first articles from the wiki_dump' do
		pages = []
		3.times do |i|
			page = @parse.get_next_page
			pages << page
		end
		pages.should have(3).items
	end

	it 'should obtain the 3 first non redirect articles from the wiki_dump' do
		pages = []
		while pages.length < 3 do
			page = @parse.get_next_page
			if !page.redirect then pages << page end
		end
		pages.should have(3).items
	end

	it 'should obtain the 3 first non redirect articles from the wiki_dump' do
		pages = []
		while pages.length < 3 do
			page = @parse.get_next_page
			if !page.redirect then pages << page end
		end
		pages.should have(3).items
	end

	it 'should obtain the 3 first non redirect and non special articles from the wiki_dump' do
		pages = []
		while pages.length < 3 do
			page = @parse.get_next_page
			if !page.redirect and !page.special_page then pages << page end
		end
		pages.should have(3).items
	end

	it 'should obtain the 3 first disambiguation pages from the wiki_dump' do
		pages = []
		while pages.length < 3 do
			page = @parse.get_next_page
			if page.disambiguation_page then pages << page end
		end
		pages.should have(3).items
	end
end