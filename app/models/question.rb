class Question < ApplicationRecord
  has_many :test_results

  validates :question_text, presence: true,format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角ひらがな・カタカナ・漢字を使用してください' }
  validates :correct_answer, presence: true,format: { with: /\A[ぁ-んー－]+\z/, message: 'は全角ひらがなを使用してください' }
end
