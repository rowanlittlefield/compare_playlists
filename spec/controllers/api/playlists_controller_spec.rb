require 'rails_helper'
require 'byebug'

RSpec.describe Api::PlaylistsController, type: :controller do

  describe 'GET #shared_track_count' do
    spotify_response_1 = {
        tracks: [
          {track: {external_ids: {isrc: '1'}}},
          {track: {external_ids: {isrc: '2'}}},
          {track: {external_ids: {isrc: 'USVI29700014'}}}
        ]
      }.to_json

    spotify_response_2 = {
        tracks: [
          {track: {external_ids: {isrc: '1'}}},
          {track: {external_ids: {isrc: '2'}}},
          {track: {external_ids: {isrc: '3'}}}
        ]
      }.to_json

    apple_music_response = {
        data: [
          {
            relationships: {
              tracks: {
                data: [
                  {
                    attributes: {
                      isrc: 'USVI29700014'
                    }
                  },
                  {
                    attributes: {
                      isrc: 'USVI20100057'
                    }
                  },
                  {
                    attributes: {
                      isrc: 'USVI20100098'
                    }
                  }
                ]
              }
            }
          }
        ]
      }.to_json

    it 'returns a non-zero count when the playlists share songs' do
      allow(SpotifyClient).to receive(:api_response).with('1').and_return(spotify_response_1)
      allow(AppleMusicClient).to receive(:api_response).with('1').and_return(apple_music_response)
      get(
        'shared_track_count',
         params: { spotify: '1', appleMusic: '1' },
         format: :json
      )
      expect(JSON.parse(response.body)).to eq({"count" => 1})
    end

    it 'returns a count of zero when the playlists do not share songs' do
      allow(SpotifyClient).to receive(:api_response).with('2').and_return(spotify_response_2)
      allow(AppleMusicClient).to receive(:api_response).with('1').and_return(apple_music_response)
      get(
        'shared_track_count',
         params: { spotify: '2', appleMusic: '1' },
         format: :json
      )
      expect(JSON.parse(response.body)).to eq({"count" => 0})
    end
  end

end
