class Api::PlaylistsController < ApplicationController

  def shared_track_count
    spotify_response = SpotifyClient.fetch_tracks(params[:spotify])
    apple_music_response = AppleMusicClient.fetch_tracks(params[:appleMusic])
    debugger
    if spotify_response[:code] == '200' && apple_music_response[:code] == '200'
      spotify_ids = spotify_track_isrc_ids_list(spotify_response[:body])
      apple_ids = apple_track_isrc_ids_list(apple_music_response[:body])
      render json: {count: common_ids_count(spotify_ids, apple_ids)}
    else
      render json: 'Invalid authorization/track ids', status: 400
    end
  end

  private

  def spotify_track_isrc_ids_list(spotify_response)
    spotify_response['tracks'].map do |track|
      track["track"]['external_ids']['isrc']
    end
  end

  def apple_track_isrc_ids_list(apple_response)
    apple_response['data'][0]['relationships']['tracks']['data'].map do |track|
      track['attributes']['isrc']
    end
  end

  def common_ids_count(id_list_one, id_list_two)
    list_one_ids_set = {}
    id_list_one.each {|id| list_one_ids_set[id] = true}
    id_list_two.select {|id| list_one_ids_set[id] }.count
  end

end
