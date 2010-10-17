#! /usr/bin/env ruby
#
# tsite.rb: getting current T-Point by scraping tsite.jp.
#
# Copyright (C) 2010 by TADA Tadashi <t@tdtds.jp>
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

agent.get( URL )

login_form = agent.page.form_with( :action => /login/ )
login_form.LOGIN_ID = @login['user']
login_form.PASSWORD = @login['pass']
login_form.click_button

agent.get( URL )
puts agent.page.at( 'div#SideMyTpoint strong' ).text

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
# vim: ts=3
