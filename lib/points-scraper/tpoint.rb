# -*- coding: utf-8 -*-
#
# tpoint.rb: T-POINT for PointsScraper
#
# Copyright (C) 2012 by TADA Tadashi <t@tdtds.jp>
# Distributed under GPL.
#

module Points::Scraper
	class TPoint
		require 'mechanize'

		URL = 'https://tsite.jp'

		def initialize( user, pass )
			@user, @pass = user, pass
		end

		def start
			agent = Mechanize::new
			agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']

			agent.get( URL + '/tm/pc/login/STKIp0001001.do' )

			agent.page.form_with( :name => 'form1' ) do |form|
				form.action = URL + '/tm/pc/login/STKIp0001010.do'
				form['LOGIN_ID'] = @user
				form['PASSWORD'] = @pass
				form.click_button
			end

			agent.page.at( 'p.point > span.number' ).text
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
