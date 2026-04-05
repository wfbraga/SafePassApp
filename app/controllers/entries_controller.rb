class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  def index
    @entries = current_user.entries
    @main_entry = @entries.first
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash.now[:notice] = "#{@entry.name} was successfully created."
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream {}
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def destroy
    @entry.destroy
    flash.now[:notice] = "#{@entry.name} was successfully destroyed."
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.turbo_stream {}
    end
  end


  private
  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
  def entry_params
    params.expect(entry: [:name, :url, :username, :password])
  end
end