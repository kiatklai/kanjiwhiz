class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    if Question.create(question_params)
      redirect_to questions_path
    else
      render :new
    end
  end

  def destroy
    question = question.find(params[:id])
    if question.destroy
      redirect_to questions_path
    end
  end

  private
  def question_params
    params.require(:question).permit(:question_text, :correct_answer)
  end
end
