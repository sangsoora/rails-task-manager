class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :new_record?, only: %i[new edit]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to task_path(@task)
  end

  def edit; end

  def update
    @task.update(task_params)
    @task.save
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def new_record?
    sync_with_transaction_state if @transaction_state&.finalized?
    @new_record
  end
end
