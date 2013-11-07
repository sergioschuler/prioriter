class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_tasks, only: [:index, :new]

  def index
  end

  #def show
  #end

  def new
    @task = current_user.tasks.build
  end

  #def edit
  #end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
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
     @tasks = current_user.tasks.where(completed: false).order('position')
     @completed_tasks = current_user.tasks.where(completed: true).order('updated_at DESC').limit(10)
    end

    def task_params
      params.require(:task).permit(:description, :completed, :position)
    end
end
