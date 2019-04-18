class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true

  has_many :authentication_tokens

  has_attached_file(
    :profile_image,
    styles: { medium: '250x250#', thumb: '100x100#' },
  )

  validates_attachment_content_type(
    :profile_image,
    content_type: %r{\Aimage\/.*\z},
    with: %r{^balls/.+\.(gif|jpe?g|png|svg)$}i,
    message: ' and have an image extension'
  )

  def generate_authentication_token(device_type,device_token)
    token = generate_auth_hash
    auth = self.authentication_tokens.create(auth_token: token, device_type: device_type, device_token: device_token)
  end

  def generate_auth_hash
    token = SecureRandom.hex(16)
    if AuthenticationToken.where(auth_token: token).present?
      generate_auth_hash
    end
    token
  end

end
