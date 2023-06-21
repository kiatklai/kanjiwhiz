class TestResultsController < ApplicationController
  def score
    # is_correctがtrueの回答の数を数えてスコアとする例
    correct_count = TestResult.where(user: self.user, is_correct: true).count
    score = correct_count * 10

    # スコアを返します
    score
  end
  
  def result
    @test_results = current_user.test_results.order(created_at: :desc).limit(5)

    # 合計点数の計算
    total_score = @test_results.sum { |result| result.score.to_i }

    # 各問題の正解とユーザーの回答を紐付けるために関連データをロードする
    @test_results.includes(:question)

    correct_question_ids = @test_results.where(is_correct: true).pluck(:question_id)
    correct_answers = Question.where(id: correct_question_ids)

    # 合計点数や正解の表示など、ビューに必要な情報を設定する
    @total_score = total_score
    @result = { total_score: total_score, correct_answers: correct_answers }
  end
end
