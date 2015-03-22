class StaticPagesController < ApplicationController
	# devise callback for user authentication
	def home
	end

	def show
		@wmata_api_key = ENV["wmata_api_key"]
		@youtube_api_key = ENV["youtube_api_key"]
	end

end