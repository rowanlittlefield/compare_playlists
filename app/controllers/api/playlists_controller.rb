require 'net/http'

class Api::PlaylistsController < ApplicationController

  def shared_track_count
    spotify_response = SpotifyClient.api_response(params[:spotify])
    apple_music_response = AppleMusicClient.api_response(params[:appleMusic])
    spotify_ids = spotify_track_isrc_ids_list(spotify_json_mock)
    apple_ids = apple_track_isrc_ids_list(apple_json_mock)

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

  def spotify_json_mock
    {
      tracks: [
        {track: {external_ids: {isrc: '1'}}},
        {track: {external_ids: {isrc: '2'}}},
        {track: {external_ids: {isrc: "USVI29700014"}}}
      ]
    }.to_json
  end

  def apple_json_mock
    {
      data: [
        {
          relationships: {
            tracks: {
              data: [
                {
                  attributes: {
                    isrc: "USVI29700014"
                  }
                },
                {
                  attributes: {
                    isrc: "USVI20100057"
                  }
                },
                {
                  attributes: {
                    isrc: "USVI20100098"
                  }
                }
              ]
            }
          }
        }
      ]
    }.to_json
  end
end
