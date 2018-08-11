class Api::PlaylistsController < ApplicationController

  def shared_track_count
    debugger

    spotify_ids = spotify_track_isrc_ids_list(spotify_json_mock)
    apple_ids = apple_track_isrc_ids_list(apple_json_mock)

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

  def apple_track_isrc_ids_list(apple_json_response)
    apple_hash = JSON.parse(apple_json_response)

    apple_hash['data'][0]['relationships']['tracks']['data'].map do |track|
      track['attributes']['isrc']
    end
  end

  private

  def spotify_json_mock
    # playlistobject = {tracks: [playlistTrackObject = {track: {external_ids: {isrc: '1'}}}, ...]}
    #tracks is an array of track objects
    #isrc is a string

    {
      tracks: [
        {track: {external_ids: {isrc: '1'}}},
        {track: {external_ids: {isrc: '2'}}},
        {track: {external_ids: {isrc: '3'}}}
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
#     {
#     "data": [
#         {
#             "relationships": {
#                 "tracks": {
#                     "data": [
#                         {
#                             "attributes": {
#                                 "isrc": "USVI29700014"
#                             }
#                         },
#                         {
#                             "attributes": {
#                                 "isrc": "USVI20100057"
#                             }
#                         },
#                         {
#                             "attributes": {
#                                 "isrc": "USVI20100098"
#                             }
#                         }
#                     ]
#                 }
#             }
#         }
#     ]
# }
  end
end
