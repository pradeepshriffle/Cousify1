class SubscriptionsController < ApplicationController
    before_action :find_id, only: [ :show, :update, :destroy ]
    # protect_from_forgery
  
    # ..................Show Subscription programs...............
    def index
        subscription = Subscription.all 
        if subscription.empty?
        render json: { message: 'No data found...' }
        else
            render json: subscription
        end
      end
  
   
  
    # ..................Subscription program.......................
    def create
      subscription = @current_user.subscriptions.new(set_params)
      course= Subscription.find_by(status: 'active', id: subscription.course_id)
    
      if course
        subscription.status = 'started'
        
        if subscription.save
          render json: subscription, status: :ok
        else
          render json: { error: subscription.errors.full_messages }
        end
      else
        render json: { message: 'Cannot add inactive program' }
      end
    end
    

    def create
      new_subscription = @current_user.subscriptions.new(set_params)
    
      active_subscription = Subscription.find_by(status: 'active', course_id: new_subscription.course_id)
    
      if active_subscription
        active_subscription.status = 'started'
        
        if active_subscription.save
          render json: active_subscription, status: :ok
        else
          render json: { error: active_subscription.errors.full_messages }
        end
      else
        if new_subscription.save
          render json: new_subscription, status: :ok
        else
          render json: { error: new_subscription.errors.full_messages }
        end
      end
    end
    
    # ..................Update Program Status.......................
      def update
          if @current_user.type=='Trainner'
              if @subscription.status == 'completed'
                  render json: { message: "course is already completed...." }
              else
                  @subscription.update(status: 'completed')
                  render json: { message: "course has been marked as completed...." }
              end
          else
              render json: { message: "You do not have permission to update this subscription." }, status: :unauthorized
          end
      end
      
  
    # ..................Show Particular Purchased Program .......................
      def show
          render json: @subscription
      end
  
    # ..................Delete Purchase .......................
      def destroy
          if @subscription.destroy
              render json: {message: "subscription has been deleted.... "}
          else
              render json: {message: "@subscription not deleted"}
          end
      end
  
      private
    def set_params
        params.permit(:course_id)
    end
  
    def find_id
          @purchase=Purchase.find_by_id(params[:id])
          unless @purchase
        render json: "Id not found.."
    end
    end
end
