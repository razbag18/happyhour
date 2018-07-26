class Special < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  # validates_uniqueness_of :venue_name
end