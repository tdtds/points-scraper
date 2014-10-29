# -*- coding: utf-8 -*-
#
# rakuten.rb: Rakuten Points for PointsScraper
# by scraping www.rakuten.co.jp.
#
# Copyright (C) 2012 by MATSUI Shinsuke <poppen.jp@gmail.com>
# Distributed under GPL.
#

require 'points-scraper/default'

module Points::Scraper
	class Rakuten < Default
		URL = 'https://point.rakuten.co.jp'

		def start
			start_scrape do |agent|
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
end

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
# vim: ts=3
