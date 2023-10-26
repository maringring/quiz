class TagRelationship < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  validates :tag_id, presence: true
  validates :question_id, presence: true
end
