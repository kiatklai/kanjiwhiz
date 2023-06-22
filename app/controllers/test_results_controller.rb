class TestResultsController < ApplicationController
  def result
    @test_results = current_user.test_results.includes(:question).order(created_at: :desc).limit(5)
    
    # 合計点数の計算
    # @total_score = @test_results.sum { |result| result.score.to_i }

    test_results = current_user.test_results.order(created_at: :desc).limit(5)

    # 合計点数の初期化
    total_score = 0

    # テスト結果の処理
    test_results.each do |result|
      # 正解の比較と点数の加算
      if result.is_correct
        total_score += 1
      end
    end

    # 合計得点をscoreカラムに保存
    test_results.first.update(score: total_score)
    
    @total_score = total_score
    end

end
