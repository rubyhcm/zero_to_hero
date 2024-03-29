class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]

  def self.from_omniauth(access_token)
    user = find_or_initialize_user(access_token)
    update_user_provider_info(user, access_token)
    user.save
    user
  end

  def self.find_or_initialize_user(access_token)
    data = access_token.info
    name = data['nickname'] || data['name']

    User.where(email: data['email']).first || User.new(
      email: data['email'],
      password: Devise.friendly_token[0, 20],
      nickname: name,
      image_url: data['image'],
      uid: access_token['uid'],
      provider: access_token['provider']
    )
  end

  def self.update_user_provider_info(user, access_token)
    user.uid = access_token['uid']
    user.provider = access_token['provider']
  end
end
