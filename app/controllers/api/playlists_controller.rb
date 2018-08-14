class Api::PlaylistsController < ApplicationController

  def shared_track_count
    spotify_response = SpotifyClient.fetch_tracks(params[:spotify])
    apple_music_response = AppleMusicClient.fetch_tracks(params[:appleMusic])
    spotify_ids = spotify_track_isrc_ids_list(spotify_response)
    apple_ids = apple_track_isrc_ids_list(apple_music_response)

    render json: {count: common_ids_count(spotify_ids, apple_ids)}
  end

  private

  def spotify_track_isrc_ids_list(spotify_json_response)
    spotify_hash = JSON.parse(spotify_json_response)

    spotify_hash['tracks'].map do |track|
      track["track"]['external_ids']['isrc']
    end
  end

  def apple_track_isrc_ids_list(apple_json_response)
    apple_hash = JSON.parse(apple_json_response)

    apple_hash['data'][0]['relationships']['tracks']['data'].map do |track|
      track['attributes']['isrc']
    end
  end

  def common_ids_count(id_list_one, id_list_two)
    list_one_ids_set = {}
    id_list_one.each {|id| list_one_ids_set[id] = true}
    id_list_two.select {|id| list_one_ids_set[id] }.count
  end

end
