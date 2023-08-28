class CoursesController < ApplicationController
    before_action :find_id, only: [ :show, :update, :destroy ]
    before_action :active_program, only: [ :show_active_program, :show_category_wise_programs ]
    # protect_from_forgery
  
    # ...................Show Course....................
    def index
        program = Course.all
      if program.present?
        render json: program
      else
        render json: { message: "No course exists" }
      end
    end
  
    # ...................Create Course....................
    def create
      if @current_user.type=="Trainner"
        course = @current_user.courses.new(set_params)
        if course.save
          render json: course
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { message: "You do not have permission to create a courses." }, status: :unauthorized
      end
    end
    
    # ..............Show particular Course................
    def show
          render json: @course
    end
  
    # ...................Update Course....................
    def update
      if @current_user.type=="Trainner"
        if @course.update(set_params)
          render json: @course
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { message: "You do not have permission to update this course." }, status: :unauthorized
      end
    end
    
  
    # .....................Destroy Course.....................
    def destroy  
      if @current_user.type=="Trainner"
        if @course.destroy
          render json: { message: 'Deleted successfully' }
        else
          render json: { message: 'Failed to delete the course' }
        end
      else
        render json: { message: 'You do not have permission to delete this course' }, status: :unauthorized
      end
    end
    
    # ..............Search Course through name.....................
    def search_course_name
      if params[:name].present?
        course = Course.where('name like ?', '%' + params[:name].strip + '%')
        if course.empty?
          render json: { message: 'No data found...' }
        else
          render json: course
        end
      else
        render json: { message: 'No record found...' }
      end
    end
  
    # ..............Search Course through status.....................
    def search_course_status
      if params[:status].present?
        course = Course.where("status like '%#{params[:status].strip}%'")
        if course.empty?
          render json: { message: 'No data found...' }
        else
          render json: course
        end
      else
        render json: { message: 'No record found...' }
      end
    end
  
    # .................Delete Customer Program............................
    # def delete_customer_purchase
    #   if params[:program_id].present? && params[:purchase_id].present?
    #     program = @current_user.programs.joins(:purchases).where("programs.id = #{ params[:program_id] } AND purchases.id = #{ params[:purchase_id] }")
    #     if program.empty?
    #       render json: {message: "Record not found"}
    #     else
    #       purchase = Purchase.find(params[:purchase_id])
    #       purchase.destroy
    #       render json: { message: "Purchase deleted successfully" }
    #     end
    #   else
    #     render json: { message: "Record not found" }
    #   end
    # end
  
    # .................Customer Functionalities....................
    # .....................Show active programs....................
    def show_active_course
    end
  
    # .....................Show category wise programs.............
    def show_category_wise_courses
    end
  
    # # ..................Search in purchased Programs.......................
    # def search_in_customer_program
    #   if params[:name].present?
    #     program = Purchase.joins(:program).where("purchases.user_id=#{ @current_user.id } AND name LIKE '%#{ params[:name].strip }%'")
    #     if program.empty?
    #       render json: { error: 'Record not found' }
    #     else
    #       render json: program
    #     end
    #   else
    #     render json: { message: "Please provide required field" }
    #   end
    # end
  
      private
    def set_params
      params.permit(:name,:status,:price,:duration,:user_id,:category_id)
    end
  
    def find_id
      @course = Course.find_by_id(params[:id])
      unless @course
        render json: "Id not found.." 
      end   
    end
  
    def active_program
      course = Course.where(status: 'active')
      unless course.empty?
        render json: program
      else
        render json: { message: 'No data found...' }
      end
    end
end
