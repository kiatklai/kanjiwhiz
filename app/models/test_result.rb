class TestResult < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_answer, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: 'は全角ひらがなを使用してください' }
end
