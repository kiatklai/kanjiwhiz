class Question < ApplicationRecord
  validates :question_text, presence: true
  validates :correct_answer, presence: true
end
