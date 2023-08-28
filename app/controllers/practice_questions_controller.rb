class PracticeQuestionsController < ApplicationController

  def index
      @practice_questions = PracticeQuestion.all
      render json: @practice_questions
   end
  
  def create
      @practice_question= PracticeQuestion.new(practice_question_params)
      if @practice_question.save
         render json: @practice_question, status: :created
       else
          render jsn: { error:"there is a some problem for create chapter " }
       end
  end
          
  def update
      @practice_question = PracticeQuestion.find(params[:id])
      if @practice_question.update(practice_question_params)
          render json: @practice_question
      else
          render json: { error:"there is a some problem for updating " }
      end 
   end
  
  def destroy
      @practice_question = PracticeQuestion.find(params[:id])
     if @practice_question.present?
        @practice_question.destroy
        head :no_content
     else
        render json: { error: "Chapter not found." }
     end
   end
  
  def show
      @practice_question= PracticeQuestion.find(params[:id])
      if @practice_question?
        render json: @practice_question
      else
        render json: { error: "Chapter not found." }
     end
   end   
  
    private      
  def practice_question_params
      params.require(:practice_question).permit(:question,:answer,:course_id)
   end      
end
