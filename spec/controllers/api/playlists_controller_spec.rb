require 'rails_helper'

RSpec.describe Api::PlaylistsController, type: :controller do

  describe 'GET #shared_track_count' do
    spotify_response_1 = {
      code: '200',
      body: {
        'tracks' => [
          {'track' => {'external_ids' => {'isrc' => '1'}}},
          {'track' => {'external_ids' => {'isrc' => '2'}}},
          {'track' => {'external_ids' => {'isrc' => 'USVI29700014'}}}
        ]
      }
    }

    spotify_response_2 = {
      code: '200',
      body: {
        'tracks' => [
          {'track' => {'external_ids' => {'isrc' => '1'}}},
          {'track' => {'external_ids' => {'isrc' => '2'}}},
          {'track' => {'external_ids' => {'isrc' => '3'}}}
        ]
      }
    }

    invalid_spotify_response = {
      code: '400',
    }

    apple_music_response = {
      code: '200',
      body: {
        'data' => [
          {
            'relationships' => {
              'tracks' => {
                'data' => [
                  {
                    'attributes' => {
                      'isrc' => 'USVI29700014'
                    }
                  },
                  {
                    'attributes' => {
                      'isrc' => 'USVI20100057'
                    }
                  },
                  {
                    'attributes' => {
                      'isrc' => 'USVI20100098'
                    }
                  }
                ]
              }
            }
          }
        ]
      }
    }

    it 'returns a non-zero count when the playlists share songs' do
      allow(SpotifyClient).to receive(:fetch_tracks).with('1').and_return(spotify_response_1)
      allow(AppleMusicClient).to receive(:fetch_tracks).with('1').and_return(apple_music_response)
      get(
        'shared_track_count',
         params: { spotify: '1', appleMusic: '1' },
         format: :json
      )
      expect(JSON.parse(response.body)).to eq({"count" => 1})
    end

    it 'returns a count of zero when the playlists do not share songs' do
      allow(SpotifyClient).to receive(:fetch_tracks).with('2').and_return(spotify_response_2)
      allow(AppleMusicClient).to receive(:fetch_tracks).with('1').and_return(apple_music_response)
      get(
        'shared_track_count',
         params: { spotify: '2', appleMusic: '1' },
         format: :json
      )
      expect(JSON.parse(response.body)).to eq({"count" => 0})
    end

    it "returns 400 level status response when playlist not found or unauthorized request is made" do
      allow(SpotifyClient).to receive(:fetch_tracks).with('').and_return(invalid_spotify_response)
      allow(AppleMusicClient).to receive(:fetch_tracks).with('1').and_return(apple_music_response)
      get(
        'shared_track_count',
         params: { spotify: '', appleMusic: '1' },
         format: :json
      )
      expect(response).to have_http_status(400)
    end
  end

end
