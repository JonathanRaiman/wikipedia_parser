Wikipedia Parser
================

Wikipedia parser lets you parse `.bz2` and `.xml` dumps of Wikipedia articles without decompressing the `.bz2` file. The Parser functions as an enumerator over the pages to stream-parse the dumps (which can take several hours to read).

Usage
-----

To get started `gem install wikipedia_parser`, then head over to [the Wikipedia dumps](http://en.wikipedia.org/wiki/Wikipedia:Database_download), and now you can:

	require 'wikipedia_parser'

	parser = WikiParser.new :path => File.dirname(__FILE__)+"/enwiki.bz2" # path to wikipedia dump

	loop do
		page = parser.get_next_page
		if !page              then break
		else
			puts page.title
			puts page.internal_links
		end
	end

The internal links contain the `title` and the `uri` of the destination page:

	loop do
		page = parser.get_next_page
		if !page              then break
		else
			page.internal_links.each do |link|
				puts link[:title][page.language.to_sym] + "points to" + link[:uri]
			end
		end
	end

For larger pages, such as **Barack Obama** or **United States** reading all the internal links takes a long time. If you are only interested in certain pages, say those that start with the letter **A**, then you could skip those pages you don't want without incuring the cost of reading the entire article since the title is at the top of the xml file. Here's one way of implementing this check:

	loop do
		page = parser.get_next_page :until => "title" # or "id" or "redirect" (boolean)
		if !page then break
		else
			if page.title ~= /^[aA]/ # starts with A
				page.finish_processing # reads the remainder of the nodes.
				page.internal_links.each do |link|
					puts link[:title][page.language.to_sym] + "points to" + link[:uri]
				end
			end
		end
	end

Testing
-------

Simply run:

	rake test

Issues
------

On `Mac` and `Linux` `bzip2` is included, but it appears that on Windows a seperate `bzip2` reader is needed.