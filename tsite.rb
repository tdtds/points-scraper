#! /usr/bin/env ruby
#
# tsite.rb: getting current T-Point by scraping tsite.jp.
#
# Copyright (C) 2011 by TADA Tadashi <t@tdtds.jp>
# Distributed under GPL.
#

require 'rubygems'
require 'mechanize'
require 'pit'

URL = 'https://tsite.jp'

@login = Pit::get( 'tsite', :require => {
	'user' => 'your ID of tsite.jp.',
	'pass' => 'your Password of tsite.jp.'
} )

agent = Mechanize::new
agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']

agent.get( URL + '/tm/pc/login/STKIp0001001.do' )

agent.page.form_with( :name => 'form1' ) do |form|
	form.action = URL + '/tm/pc/login/STKIp0001010.do'
	form['LOGIN_ID'] = @login['user']
	form['PASSWORD'] = @login['pass']
	form.click_button
end

puts agent.page.at( 'strong.SideMyPoint' ).text

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
# vim: ts=3
