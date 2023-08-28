class SubscriptionsController < ApplicationController
	def index
	  @subscriptions = Subscription.all
	  render json: @subscriptions
	end

  def create
    if student? 
      @subscription = Subscription.new(subscription_params)
     if @subscription.save
        render json: @subscription, status: :created
      else
        render json: { errors: "you can't subscribed this course" }
      end
    else
      render_teacher_error
   end
  end

  def show
      @subscription= Subscription.find(params[:id])
			render json: @subscription
   end 
  
  private

  def subscription_params
      params.require(:subscription).permit(:user_id, :course_id)  
    end

  def student?
      user = User.find_by(id:subscription_params[:user_id])
      user.present? && user.user_type == 'student'
   end
  
  def render_teacher_error
      render json: { error: "Only student Type Userperform this action." }
   end  
end 