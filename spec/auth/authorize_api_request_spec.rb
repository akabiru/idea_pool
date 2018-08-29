# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => token_generator } }
  subject(:invalid_request_object) { described_class.new({}) }
  subject(:request_object) { described_class.new(headers) }

  describe '#user' do
    context 'when valid request' do
      it 'returns user object' do
        expect(request_object.user).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_object.user }.to raise_error(
            JsonWebToken::MissingToken, 'Missing token'
          )
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_object) do
          described_class.new('Authorization' => Faker::Internet.device_token)
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_object.user }.to raise_error(
            JsonWebToken::InvalidToken, /Invalid token/
          )
        end
      end

      context 'when token is expired' do
        let(:headers) { { 'Authorization' => expired_token_generator } }
        subject(:request_object) { described_class.new(headers) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect { request_object.user }.to raise_error(
            JsonWebToken::InvalidToken,
            /Signature has expired/
          )
        end
      end

      context 'fake token' do
        let(:headers) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_object) { described_class.new(headers) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request_object.user }.to raise_error(
            JsonWebToken::InvalidToken,
            /Not enough or too many segments/
          )
        end
      end
    end
  end
end
