class WikiParser

	# A Wikipedia article page object.
	class Page

		# The Wikipedia namespaces for all special pages {WikiParser::Page#special_page}, {#page_type}.
		Namespaces = %w(WP Help Talk User Template Wikipedia File Book Portal TimedText Module MediaWiki Special Media Category)
		# Title of the Wikipedia article.
		attr_reader :title
		# The Wikipedia id of the article.
		attr_reader :id
		attr_reader :internal_links
		# the content of the Wikipedia article
		attr_reader :article
		# is this page a redirection page?
		attr_reader :redirect
		# the title of the page this article redirects to.
		attr_reader :redirect_title
		# the wikipedia namespace for this page
		attr_reader :page_type
		# is this page `special`? Is it in the {Namespaces}?
		attr_reader :special_page
		attr_reader :disambiguation_page

		# Create a new article page from an XML node.
		# @param opts [Hash] the parameters to instantiate a page.
		# @option opts [Nokogiri::XML::Node] :node the {http://rubydoc.info/gems/nokogiri/frames Nokogiri::XML::Node} containing the article.
		# @option opts [Fixnum] :from the index from which to resume parsing among the nodes.
		# @option opts [String] :until A node-name stopping point for the parsing.
		def initialize (opts={})
			@title    = @article      = @redirect_title      = ""
			@redirect = @special_page = @disambiguation_page = false
			@internal_links, @page_type = [], nil
			return unless !opts[:node].nil?
			process_node opts
			trigs = article_to_internal_links(@article)
			@internal_links = trigs
		end

		def process_node(opts={})
			opts[:node].element_children.each_with_index do |node,k|
				if opts[:from] and k < opts[:from] then next end
				case node.name
				when 'id'
					@id    = node.content
				when 'title'
					@title = node.content
					if @title.match(/(#{Namespaces.join("|")}):.+/i) then @special_page = true and @page_type = $1 end
					if @title.match(/.+ \(disambiguation\)/i)      then @disambiguation_page = true end
				when 'redirect'
					@redirect = true
					@redirect_title = node["title"]
				when 'revision'
					node.element_children.each do |rev_node|
						if rev_node.name == 'text'
							@article = rev_node.content
						end
					end
				end
				if opts[:until] and opts[:until] == node.name
					@node, @stop_index = opts[:node], k
					break
				end
			end
		end

		# Extracts internals links from a wikipedia article into an array of `uri`s and `title`s, starting
		# from the stopping point given to the parser earlier.
		# @return [WikiParser::Page] the parser.
		def finish_processing
			@stop_index||= 0
			process_node :node => @node, :from => @stop_index
			@node = nil
			self
		end

		# Extracts internals links from a wikipedia article into an array of `uri`s and `title`s:
		# @param article [String] the article content to extract links from.
		# @return [Array<Hash>] the internal links in hash form.
		def article_to_internal_links article
			links = []
			matches = article.scan(/\[\[(?<name>[^\]\|:]+)(?<trigger>\|[^\]]+)?\]\]/)
			if matches
				matches.each do |match|
					name_match = match[0].strip.chomp.match(/^(?<name>[^#]+)(?<hashtag>#.+)?/)
					link_match = match[1] ? match[1].strip.chomp.match(/^\|[\t\n\s\/]*(?<name>[^#]+)(?<hashtag>#.+)?/) : name_match
					if name_match
						name_match = name_match[:name].gsub('_', ' ')
						link_match = link_match ? link_match[:name] : name_match
						links << {:uri => name_match, :title => link_match}
					end
				end
			end
			links
		end

		private :process_node
	end
end