require 'rails_helper'
require 'byebug'

RSpec.describe PlaylistsController, type: :controller do
  let(:spotify_response) {
    {
      tracks: [
        {track: {external_ids: {isrc: '1'}}},
        {track: {external_ids: {isrc: '2'}}},
        {track: {external_ids: {isrc: "USVI29700014"}}}
      ]
    }.to_json
  }

  let(:apple_music_response) {
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
  }
  describe 'GET #shared_track_count' do
    it 'returns a non-zero count when the playlists share songs' do
      
      get(
        'shared_track_count',
         params: { spotify: '1', appleMusic: '1' },
         format: :json
      )
      expect(JSON.parse(response.body)).to eq({"count" => 1})
    end
  end

end
