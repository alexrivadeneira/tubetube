class StaticPagesController < ApplicationController
	# devise callback for user authentication
	def home
	end

	def show
		@wmata_api_key = ENV["wmata_api_key"]
		@youtube_api_key = ENV["youtube_api_key"]
	end

	def test
		wmata_api_key = ENV["wmata_api_key"]

		request_url = "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo?FromStationCode=A04&ToStationCode=A06&api_key="
		request_url += wmata_api_key

		@wmata_data = HTTParty.get(request_url)
	end


end
