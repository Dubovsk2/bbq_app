class Photograph < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :event
  belongs_to :user

  validates :photo, presence: true
end
