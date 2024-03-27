class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    name = data["nickname"] || data["name"]
    user ||= User.create(
      email: data["email"],
      password: Devise.friendly_token[0, 20],
      nickname: name,
      image_url: data["image"],
      uid: access_token["uid"],
      provider: access_token['provider']
    )
    user.save
    user
  end
end
