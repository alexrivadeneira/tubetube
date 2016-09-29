class StaticPagesController < ApplicationController
	# devise callback for user authentication
	def home
	end



	def submit
		stopcodeA = params["metro_station_a"]
		stopcodeB = params["metro_station_b"]

		if stopcodeA == stopcodeB
			@no_time = true
			return @no_time

		else
			wmata_request_url = "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo?FromStationCode="
			wmata_request_url += stopcodeA
			wmata_request_url += "&ToStationCode="
			wmata_request_url += stopcodeB
			wmata_request_url += "&api_key="
			wmata_request_url += ENV["wmata_api_key"]

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

			puts @wmata_data["StationToStationInfos"][0]["RailTime"]
			youtube_api_key = ENV["youtube_api_key"]
			youtube_request_url += youtube_api_key
			puts(youtube_request_url)

			@youtube_data = HTTParty.get(youtube_request_url)
		end
	end

end
