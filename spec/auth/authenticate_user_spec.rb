require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }

  describe '.authenticate!' do
    context 'when valid credentials' do
      subject { described_class.authenticate!(user.email, user.password) }

      it 'returns an auth token' do
        expect(subject).not_to be(nil)
        expect(subject).to be_a(String)
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

  describe '#authenticate!' do
    context 'when valid credentials' do
      subject { described_class.new(user.email, user.password) }

      it 'returns an auth token' do
        token = subject.authenticate!

        expect(token).not_to be(nil)
        expect(token).to be_a(String)
      end
    end

    context 'when invalid credentials' do
      subject { described_class.new('foo', 'bar') }

      it 'raises an authentication error' do
        expect { subject.authenticate! }.to raise_error(
          AuthenticateUser::AuthenticationError,
          /Invalid credentials/
        )
      end
    end
  end
end
