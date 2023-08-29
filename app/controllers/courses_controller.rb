class CoursesController < ApplicationController
 before_action :find_id, only: [:show, :update, :destroy]

  # Show Course
  def index
    course = Course.all
    if course.present?
      render json: course
    else
      render json: { message: "No course exists" }
    end
  end

  # Create Course
  def create
    if @current_user.type == "Trainner"
      course = @current_user.courses.new(set_params)
      if course.save
        render json: course
      else
        render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You do not have permission to create a course." }, status: :unauthorized
    end
  end

  # Show particular Course
  def show
    render json: @course
  end

  # Update Course
  def update
    if @current_user.type == "Trainner"
      if @course.update(set_params)
        render json: @course
      else
        render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You do not have permission to update this course." }, status: :unauthorized
    end
  end

  # Destroy Course
  def destroy
    if @current_user.type == "Trainner"
      if @course.destroy
        render json: { message: 'Deleted successfully' }
      else
        render json: { message: 'Failed to delete the course' }
      end
    else
      render json: { message: 'You do not have permission to delete this course' }, status: :unauthorized
    end
  end

  # Search Course through name
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

  # Search Course through status
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

  # Show active programs
  def show_active_course
    course = Course.where(status: 'active')
    unless course.empty?
      render json: course
    else
      render json: { message: 'No data found...' }
    end
  end

  private

  def set_params
    params.permit(:name, :status, :price, :duration, :user_id, :category_id)
  end

  def find_id
    @course = Course.find_by_id(params[:id])
    unless @course
      render json: "Id not found.."
    end
  end
end

