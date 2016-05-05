class Note < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { maximum: 500 }
  belongs_to :user
  belongs_to :course
end
