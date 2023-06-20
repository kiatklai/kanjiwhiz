class TestResultsController < ApplicationController
  # テスト結果の表示
  def result
    @test_results = current_user.test_results.order(created_at: :desc).limit(5)

    # 合計点数の計算
    total_score = @test_results.sum(&:score)

    # 各問題の正解とユーザーの回答を紐付けるために関連データをロードする
    @test_results.includes(:question)

    # 各問題の正解とユーザーの回答を取得して表示するための処理を行う
    # ...

    # 合計点数や正解の表示など、ビューに必要な情報を設定する
    @total_score = total_score

  end
end
