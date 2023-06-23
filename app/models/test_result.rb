class TestResult < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_answer, presence: true, format: { with: /\A[ぁ-んァ-ヶー－]+\z/, message: 'は全角ひらがな・カタカナを使用してください' }
end
