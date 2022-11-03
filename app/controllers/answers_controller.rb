class AnswersController < ApplicationController
  def show; end

  def new; end

  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to question_answer_path(@answer.question, @answer)
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  helper_method :answer
end
