class PostsController < ApplicationController
	def index
		require 'mechanize'
		agent = Mechanize.new
		agent.get("http://www.google.com")
		form = agent.page.forms.first
		form.q = "What is Ruby"
		form.submit
		link = agent.page.link_with(text: "Ruby vs Python: Choosing Your First Programming Language ...")
		link.click
		agent.page.search(".top-level-nav a").each do |item|
			Post.create!(title: item.text.strip)
		end
		@posts = Post.all
	end
end
