class TestResult < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_answer, presence: true
end
