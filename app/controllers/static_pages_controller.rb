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
		wmata_request_url = "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo?FromStationCode=A04&ToStationCode=A06&api_key="
		wmata_request_url += wmata_api_key
		@wmata_data = HTTParty.get(wmata_request_url)

		youtube_request_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&videoDuration="
		
		if @wmata_data["StationToStationInfos"][0]["RailTime"].to_i < 5
			youtube_request_url += "short"
		elsif @wmata_data["StationToStationInfos"][0]["RailTime"].to_i >= 5 && (@wmata_data["StationToStationInfos"][0]["RailTime"].to_i < 20)
			youtube_request_url += "medium"
		elsif @wmata_data["StationToStationInfos"][0]["RailTime"].to_i >= 20
			youtube_request_url += "long"
		end

		youtube_request_url += "&key="

		youtube_api_key = "AIzaSyClq2CUuLKU5XpVfV68kM4Yv4mAk_bmZSg"
		youtube_request_url += youtube_api_key
		puts youtube_request_url

		@youtube_data = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&videoDuration=long&key=AIzaSyClq2CUuLKU5XpVfV68kM4Yv4mAk_bmZSg")

	end


end
