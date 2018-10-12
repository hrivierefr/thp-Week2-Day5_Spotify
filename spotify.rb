require "base64"
require "HTTParty"
require 'dotenv/load'

def encoding (client_id, client_secret)
	return "Basic " + Base64.strict_encode64("#{client_id}:#{client_secret}")
end
#puts encoding(ENV["client_id"],ENV["secret_id"])

token_request = HTTParty.post(
	"https://accounts.spotify.com/api/token",
  	body: {'grant_type' => 'client_credentials'},
	headers: {'Authorization': encoding(ENV["client_id"],ENV["secret_id"]) }
)
puts token_request
#["access_token"]

get_latest_release = HTTParty.get(
	"https://api.spotify.com/v1/browse/new-releases?limit=2",
	headers: {
      "Content-Type": 'application/json',
      "Accept": 'application/json',
      "Authorization": "Bearer #{token_request["access_token"]}"
    }
)

#puts get_latest_release

user_id = HTTParty.get(
	"https://api.spotify.com/v1/me",
	headers: {
      "Content-Type": 'application/json',
      "Accept": 'application/json',
      "Authorization": "Bearer #{token_request["access_token"]}"
  }

)
puts user_id

#create_playlist = HTTParty.post(
#	"https://api.spotify.com/v1/users/{user_id}/playlists"	)