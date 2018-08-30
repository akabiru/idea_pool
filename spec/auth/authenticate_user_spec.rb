require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }

  describe '.authenticate!' do
    context 'when valid credentials' do
      subject { described_class.authenticate!(user.email, user.password) }

      it 'returns a JWT session' do
        expect(subject).to be_a(JWTSessions::Session)
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { described_class.authenticate!('foo', 'bar') }.to raise_error(
          AuthenticateUser::AuthenticationError,
          /Invalid credentials/
        )
      end
    end
  end

  describe '.login' do
    context 'when valid credentials' do
      subject { described_class.login(user.email, user.password) }

      it 'returns the current user' do
        expect(subject).to eq(user)
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { described_class.login('foo', 'bar') }.to raise_error(
          AuthenticateUser::AuthenticationError,
          /Invalid credentials/
        )
      end
    end
  end
end
