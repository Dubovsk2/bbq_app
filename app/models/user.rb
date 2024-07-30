class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions
  has_many :photographs

  before_validation :set_name

  validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, length: {maximum: 255}, uniqueness: true

  def set_name
    self.name = self.email.gsub(/@[a-zA-Z0-9\-_.]+/, "") unless self.name.present?
  end
end
