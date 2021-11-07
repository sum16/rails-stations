class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
    @movies = Movie.all
  end

  def new
    @schedule = Schedule.new
    @movie = Movie.find(params[:movie_id])
  end

  def show    
    @movie = Movie.find(params[:id])
    @schedule = Schedule.find(params[:id])
  end

  def create
    movie = Movie.find(params[:schedule][:movie_id])
    if schedule = movie.schedules.create!(schedule_params)
    redirect_to admin_schedule_path(schedule.id)
    else
      render :new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      redirect_to admin_schedule_path(schedule)
    else
      render :edit
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    if schedule.destroy
      redirect_to admin_schedules_path
    else
      render :index
    end
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time, :movie_id)
  end
end
