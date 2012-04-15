# -*- coding: utf-8 -*-
#
# default.rb: PointsScraper commons
#
# Copyright (C) 2012 by TADA Tadashi <t@tdtds.jp>
# Distributed under GPL.
#

module Points::Scraper
	class Default
		require 'mechanize'

		def initialize( user, pass )
			@user, @pass = user, pass
		end

	private
		def start_scrape
			agent = Mechanize::new
			agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']
			yield agent
		end
	end
end
