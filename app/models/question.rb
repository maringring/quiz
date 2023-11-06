class Question < ApplicationRecord
    has_many :tag_relationships, dependent: :destroy
    has_many :tags, through: :tag_relationships

    has_many :question_similar_words
    #, inverse_of: :question
    # , dependent: :destroy
    accepts_nested_attributes_for :question_similar_words, reject_if: :all_blank, allow_destroy: true
end
