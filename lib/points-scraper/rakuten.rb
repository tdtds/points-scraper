# -*- coding: utf-8 -*-
#
# rakuten.rb: Rakuten Points for PointsScraper
# by scraping www.rakuten.co.jp.
#
# Copyright (C) 2012 by MATSUI Shinsuke <poppen.jp@gmail.com>
# Distributed under GPL.
#

module Points::Scraper
	class Rakuten
		require 'mechanize'

		URL = 'https://point.rakuten.co.jp'

		def initialize( user, pass )
			@user, @pass = user, pass
		end

		def start
			agent = Mechanize::new
			agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']

			page = agent.get(URL)

			login_page = agent.click( page.link_with(:href => /login/i) )
			point_page = login_page.form_with(:name => 'LoginForm') do|form|
				form.u = @user
				form.p = @pass
			end.click_button

			point_page.at('//div[@id="pointAccount"]//dl[@class="total"]/dd').text
		end
	end
end

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
# vim: ts=3
