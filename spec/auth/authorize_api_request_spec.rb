# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }

  describe '.authorize!' do
    subject(:auth) { described_class.authorize!(payload) }

    context 'when valid request' do
      let(:payload) { { 'user_id' => user.id } }

      it 'returns the user' do
        expect(auth).to eq(user)
      end
    end

    context 'when invalid request' do
      let(:payload) { { 'user_id' => 1728378 } }

      it 'raises an error' do
        expect { auth }.to raise_error(
          JsonWebToken::InvalidToken,
          /Invalid token/
        )
      end
    end
  end
end
