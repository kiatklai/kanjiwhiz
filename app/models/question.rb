class Question < ApplicationRecord
  has_many :test_results

  validates :question_text, presence: true
  validates :correct_answer, presence: true
end
