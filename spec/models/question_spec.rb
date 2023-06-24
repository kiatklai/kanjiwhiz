require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
  end
  
  describe '問題を作成時に情報入力' do
    context '問題情報入力できる場合' do
      it '全ての値が正しく入力されていれば作成できること' do
        expect(@question).to be_valid
      end
    end

    context '問題情報の入力がうまくいかない場合' do
      it 'question_textが空だと作成できない' do
        @question.question_text = ''
        @question.valid?
        expect(@question.errors.full_messages).to include("問題を入力してください")
      end

      it 'question_textが半角数字のみのときに登録できないこと' do
        @question.question_text = '123456'
        @question.valid?
        expect(@question.errors.full_messages).to include("問題は全角ひらがな・カタカナ・漢字を使用してください")
      end

      it 'question_textが半角英語のみのときに登録できないこと' do
        @question.question_text = 'abcdef'
        @question.valid?
        expect(@question.errors.full_messages).to include("問題は全角ひらがな・カタカナ・漢字を使用してください")
      end

      it 'correct_answerが空だと作成できない' do
        @question.correct_answer = ''
        @question.valid?
        expect(@question.errors.full_messages).to include("解答を入力してください")
      end

      it 'correct_answerが半角数字のみのときに登録できないこと' do
        @question.correct_answer = '123456'
        @question.valid?
        expect(@question.errors.full_messages).to include("解答は全角ひらがなを使用してください")
      end

      it 'correct_answerが半角英語のみのときに登録できないこと' do
        @question.correct_answer = 'abcdef'
        @question.valid?
        expect(@question.errors.full_messages).to include("解答は全角ひらがなを使用してください")
      end

    end
  end
end
