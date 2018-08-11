class Api::PlaylistsController < ApplicationController

  def shared_track_count
    debugger
# playlistobject = {tracks: [playlistTrackObject = {track: {external_ids: {isrc: '1'}}}, ...]}
#tracks is an array of track objects
#isrc is a string
    spotify_json_mock = {
      tracks: [
        {track: {external_ids: {isrc: '1'}}},
        {track: {external_ids: {isrc: '2'}}},
        {track: {external_ids: {isrc: '3'}}}
      ]
    }.to_json
    spotify_ids = spotify_track_isrc_ids_list(spotify_json_mock)

    debugger
    x = 5
    render json: {count: x}
  end

  def spotify_track_isrc_ids_list(spotify_json_response)
    spotify_hash = JSON.parse(spotify_json_response)

    spotify_hash['tracks'].map do |track|
      track["track"]['external_ids']['isrc']
    end
  end
end
