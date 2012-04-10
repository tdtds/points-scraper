# -*- coding: utf-8 -*-
#
# amileage.rb: mileage by scraping www.ana.co.jp. for PointsScraper
#
# Copyright (C) 2012 by MATSUI Shinsuke <poppen.jp@gmail.com>
# Distributed under GPL.
#

module Points::Scraper
	class AnaMileage
		require 'mechanize'

		URL = 'https://www.ana.co.jp/'

		def initialize( user, pass )
			@user, @pass = user, pass
		end

		def start
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

			agent.page.at('//div[@class="mileInfo_a2"]//span[1]').text
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
