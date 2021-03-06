require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /me' do
    let(:user) { create(:user) }
    let(:headers) { valid_headers }

    context 'when valid request' do
      before do
        get '/me', params: {}, headers: headers
      end

      it 'returns the current user' do
        expect(json).to eq(
          'email' => user.email,
          'name' => user.name,
          'avatar_url' => user.avatar_url
        )
      end
    end
  end

  describe 'POST /users' do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end

    context 'when valid request' do
      before do
        post '/users', params: valid_attributes.to_json, headers: headers
      end

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns an access token' do
        expect(json['jwt']).not_to be_nil
      end

      it 'returns a refresh token' do
        expect(json['refresh_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/users', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match(
          "Validation failed: Password can't be blank, Email can't be blank,"\
          " Name can't be blank, Password digest can't be blank"
        )
      end
    end
  end
end
