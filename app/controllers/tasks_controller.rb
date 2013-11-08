class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_tasks, only: [:index]

  def index
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.js
        #format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.js
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.js
      #format.json { head :no_content }
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.update_all({position: index+1}, {id: id})
    end
    render nothing:true
  end

  private
    
    def set_task
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to tasks_path, notice: "Invalid task." if @task.nil?
    end

    def set_tasks
      @tasks = current_user.tasks
      @todays_tasks = @tasks.order("position").select { |task| task["deadline"] == Date.today && task["completed"] == false }
      @future_tasks = @tasks.order("position").select { |task| task["deadline"] != Date.today && task["completed"] == false }
      @completed_tasks = (@tasks.select { |task| task["completed"] == true }).reverse.take(10)
    end

    def task_params
      params.require(:task).permit(:description, :completed, :deadline, :position)
    end
end
