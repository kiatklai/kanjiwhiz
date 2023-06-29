require 'rails_helper'

RSpec.describe TestResult, type: :model do
  before do
    user = FactoryBot.create(:user)
    question = FactoryBot.create(:question)
    @test_result = FactoryBot.build(:test_result, user_id: user.id, question_id: question.id)
  end

  describe 'テスト結果情報の保存' do
    context 'テスト結果の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@test_result).to be_valid
      end
      it 'scoreが空でも保存できる' do
        @test_result.score = nil
        expect(@test_result).to be_valid
      end
    end

    context 'テスト結果情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @test_result.user_id = ''
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("Userを入力してください")
      end
      it 'question_idが空だと保存できない' do
        @test_result.question_id = ''
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("Questionを入力してください")
      end
      it 'user_answerが空だと作成できない' do
        @test_result.user_answer = ''
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("かいとうを入力してください")
      end

      it 'user_answerが半角数字のみのときに登録できないこと' do
        @test_result.user_answer = '123456'
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("かいとうは全角ひらがなを使用してください")
      end

      it 'user_answerが半角英語のみのときに登録できないこと' do
        @test_result.user_answer = 'abcdef'
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("かいとうは全角ひらがなを使用してください")
      end

      it 'user_answerが半角カタカナのみのときに登録できないこと' do
        @test_result.user_answer = 'カンジ'
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("かいとうは全角ひらがなを使用してください")
      end

      it 'user_answerが漢字のみのときに登録できないこと' do
        @test_result.user_answer = '日本'
        @test_result.valid?
        expect(@test_result.errors.full_messages).to include("かいとうは全角ひらがなを使用してください")
      end
    end
  end
end
