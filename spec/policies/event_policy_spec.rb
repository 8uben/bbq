require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { User.create!(email: '1@test.com', password: '123123') }
  let(:user_has_not_event) { User.create!(email: '2@test.com', password: '123123') }

  let(:event) do
    Event.create(title: 'заголовок', address: 'city', datetime: Time.now, user: user)
  end

  subject { described_class }

  context 'when user in not an owner' do
    permissions :create? do
      it { is_expected.to permit(user, Event) }
      it { is_expected.not_to permit(nil, Event) }
    end

    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(user_has_not_event, event) }
    end
  end

  context 'when user in an owner' do
    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
    end
  end
end
