class SubscriptionsController < ApplicationController
  before_action :find_user_and_course, only: [:index, :create]
  before_action :find_subscription, only: [:show]

  def index
    render json: @course.subscriptions
  end

  def create
    if student?
      @subscription = @course.subscriptions.new(subscription_params)
      if @subscription.save
        render json: @subscription, status: :created
      else
        render json: { errors: "Unable to create a subscription for this course" }, status: :unprocessable_entity
      end
    else
      render_student_error
    end
  end

  def show
    render json: @subscription
  end

  private
  def subscription_params
         params.require(:subscription).permit(:user_id, :course_id)  
   end

  def student?
    @user.user_type == 'student'
  end

  def render_student_error
    render json: { error: "Only student_type users can perform this action." }, status: :forbidden
  end

  def find_user_and_course
    @user = User.find_by(id: params[:user_id])
    @course = Course.find_by(id: params[:course_id], user_id: @user&.id)
    unless @user && @course
      render json: { error: "User or course not found." }, status: :not_found
    end
  end

  def find_subscription
    @subscription = Subscription.find_by(id: params[:id])
    unless @subscription
      render json: { error: "Subscription not found." }, status: :not_found
    end
  end
end 