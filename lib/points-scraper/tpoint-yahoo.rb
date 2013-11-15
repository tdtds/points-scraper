# -*- coding: utf-8 -*-
#
# tpoint.rb: T-POINT for PointsScraper
#
# Copyright (C) 2012 by TADA Tadashi <t@tdtds.jp>
# Distributed under GPL.
#

require 'points-scraper/default'

module Points::Scraper
	class TPointYahoo < Default

		def start
			start_scrape do |agent|
				agent.user_agent = 'Mozilla/5.0 (Linux; U; Android 2.3.2; ja-jp; SonyEricssonSO-01C Build/3.0.D.2.79) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'
				agent.get('http://login.yahoo.co.jp/config/login?.lg=jp&.intl=jp&logout=1&.src=www&.done=http://www.yahoo.co.jp')

				sleep 2
				agent.get('https://login.yahoo.co.jp/config/login?.src=www&.done=http://www.yahoo.co.jp')
				agent.page.form_with(name: 'login_form') do |form|
					form.field_with(name: 'login').value = @user
					form.field_with(name: 'passwd').value = @pass
					agent.page.body =~ /\("\.albatross"\)\[0\]\.value = "(.*)"/
					form.field_with(name: '.albatross').value = $1
					form.click_button
				end

				sleep 2
				agent.get('http://points.yahoo.co.jp/')
				agent.page.at('.ptsPoint').text
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

