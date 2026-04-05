class EntriesController < ApplicationController
  before_action :authenticate_user!
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
      redirect_to root_path, notice: "Entry was successfully created."
    else
      flash[:alert] = "Sorry, there was an error creating the entry."
      render :new, status: :unprocessable_entity
    end
  end

  private
    def entry_params
      params.expect(entry: [:name, :url, :username, :password])
    end
end