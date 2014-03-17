# -*- coding: utf-8 -*-
#
# amileage.rb: mileage by scraping www.ana.co.jp. for PointsScraper
#
# Copyright (C) 2012 by MATSUI Shinsuke <poppen.jp@gmail.com>
# Distributed under GPL.
#

require 'points-scraper/default'

module Points::Scraper
	class AnaMileage < Default
		URL = 'https://www.ana.co.jp/'

		def start
			start_scrape do |agent|
				agent = Mechanize::new
				agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']

				agent.get(URL)

				agent.page.form_with(:name => 'loginForm') do|form|
					form.custno = @user
					form.password = @pass
					form.click_button
				end

				agent.page.forms[0].tap do|form|
					form.encoding = 'CP932'
					form.click_button
				end

				agent.page.at('ul.point-list a').text.gsub(/,/, '')
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
