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

@login = Pit::get( 'tsite', :require => {
	'user' => 'your ID of tsite.jp.',
	'pass' => 'your Password of tsite.jp.'
} )

agent = WWW::Mechanize::new
agent.set_proxy( *ENV['HTTP_PROXY'].split( /:/ ) ) if ENV['HTTP_PROXY']

agent.get( 'https://tsite.jp' )

login_form = agent.page.form_with( :action => /login/ )
login_form.kaiin_no = @login['user']
login_form.password = @login['pass']
login_form.click_button

agent.get( 'https://tsite.jp' )
puts agent.page.at( 'div#SideMyTpoint strong' ).text

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
# vim: ts=3
