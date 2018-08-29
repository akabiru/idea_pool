# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ideas API', type: :request do
  let(:user) { create(:user) }
  let!(:ideas) { create_list(:idea, 10, user: user) }
  let(:idea_id) { ideas.first.id }
  let(:headers) { valid_headers }

  describe 'GET /ideas' do
    before { get '/ideas', params: {}, headers: headers }

    it 'returns ideas' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /ideas/:id' do
    before { get "/ideas/#{idea_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the idea' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(idea_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:idea_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Idea/)
      end
    end
  end

  describe 'POST /ideas' do
    let(:valid_attributes) do
      {
        content: 'Code and code some more!',
        impact: 8,
        ease: 8,
        confidence: 8
      }.to_json
    end

    context 'when request is valid' do
      before { post '/ideas', params: valid_attributes, headers: headers }

      it 'creates a Idea' do
        expect(json['content']).to eq('Code and code some more!')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { content: nil }.to_json }

      before { post '/ideas', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(
          /Validation failed: Content can't be blank/
        )
      end
    end
  end

  describe 'PUT /ideas/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before do
        put "/ideas/#{idea_id}", params: valid_attributes, headers: headers
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /ideas/:id' do
    before { delete "/ideas/#{idea_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
