require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_social_network_oauth' do
    # Создаём объект :access_token
    # В него записываем те данные, которые мы доставали их хеша
    let(:access_token) do
      double(
        :access_token,
        provider: 'facebook',
        info: double(
          name: 'Владислав',
          email: 'vladislav.fdv@mail.ru',
          image: 'https://dummyimage.com/1080x1437'
        ),
        extra: double(raw_info: double(id: '101342150919664'))
      )
    end

    # Ситуация: пользователь не найден
    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_social_network_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'vladislav.fdv@mail.ru'
      end
    end

    # Ситуация: юзер найден по почте
    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'vladislav.fdv@mail.ru') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_social_network_oauth(access_token)).to eq existing_user
      end
    end

    # Ситуация: юзер не найден по почте
    context 'when user is found by email' do
      let(:access_token) do
        double(
          :access_token,
          provider: 'vkontakte',
          info: double(
            name: 'Владислав',
            email: nil,
            image: 'https://dummyimage.com/1080x1437'
          ),
          extra: double(raw_info: double(id: '22579123'))
        )
      end

      it 'returns newly created user' do
        user = User.find_for_social_network_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq '22579123@vk.com'
      end
    end

    # Ситуация: юзер найден по провайдеру и урлу
    context 'when user is found by provider + url' do
      let!(:existing_user) do
        create(:user, provider: 'facebook',
               url: 'https://facebook.com/101342150919664')
      end

      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_social_network_oauth(access_token)).to eq existing_user
      end
    end
  end
end
