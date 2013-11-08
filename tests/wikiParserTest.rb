# coding: utf-8
require(File.dirname(__FILE__)+"/../lib/wikipedia_parser.rb")

extractable_text = File.open(File.dirname(__FILE__)+"/test_article.txt").read

extracted_triggers = [
	{:uri => "Formula One",             :title => "Formula One"},
	{:uri => "Hungaroring",             :title => "Hungaroring"},
	{:uri => "Mogyoród",                :title => "Mogyoród"},
	{:uri => "Budapest",                :title => "Budapest"},
	{:uri => "Hungary",                 :title => "Hungary"},
	{:uri => "2008 Formula One season", :title => "2008 Formula One season"},
	{:uri => "Heikki Kovalainen",       :title => "Heikki Kovalainen"},
	{:uri => "McLaren",                 :title => "McLaren"},
	{:uri => "Timo Glock",              :title => "Timo Glock"},
	{:uri => "Toyota F1",               :title => "Toyota"},
	{:uri => "Kimi Räikkönen",          :title => "Kimi Räikkönen"},
	{:uri => "Scuderia Ferrari",        :title => "Ferrari"}
]

describe WikiParser do

	it 'should return internal links' do
		parse = WikiParser::Page.new
		parse.article_to_internal_links(extractable_text).should eq(extracted_triggers)
	end

	it 'should find a page\'s title' do
		parse = WikiParser.new :path => File.dirname(__FILE__)+"/test_dump.xml"
		page = parse.get_next_page
		page.title.should eq("Foobar")
	end

	it 'should find a page\'s internal links' do
		parse = WikiParser.new :path => File.dirname(__FILE__)+"/test_dump.xml"
		page = parse.get_next_page
		page.internal_links.should have(13).items
	end

end