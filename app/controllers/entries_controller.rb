class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]
  def index
    @entries = current_user.entries.search(params[:name]) || current_user.entries.order(:name)
    @entries = (@entries.to_a + Entry.joins(:shares).where(shares: { user_id: current_user.id }).to_a).uniq
    @main_entry = @entries.first
    @colleagues = User.where.not(id: current_user.id).order(email: :asc)

    return unless params[:name].present?
    if @entries.length == 1
      render turbo_stream: [
        turbo_stream.update("main-dashboard", partial: "entries/main", locals: { entry: @entries.first }),
        turbo_stream.update("entries-list", partial: "entries/entry", locals: { entry: @entries.first })
      ]
    elsif @entries.empty?
      flash.now[:notice] = "No entries found"
    end
  end

  def show
    @entry = current_user.entries.find(params[:id])
    @main_entry = @entry
    @colleagues = User.where.not(id: current_user.id).order(email: :asc)
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      @main_entry = @entry
      @colleagues = User.where.not(id: current_user.id).order(email: :asc)
      flash.now[:notice] = "#{@entry.name} was successfully created."
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @main_entry = @entry
    @colleagues = User.where.not(id: current_user.id).order(email: :asc)
    params = entry_params if entry_params[:password].blank?
    params.delete(:password) if params[:password].blank?
    if @entry.update(params)
      flash.now[:notice] = "#{@entry.name} was successfully updated."
      respond_to do |format|
        format.html { redirect_to @entry }
        format.turbo_stream { }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    flash.now[:notice] = "#{@entry.name} was successfully destroyed."
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.turbo_stream { }
    end
  end


  def share
    @entry = current_user.entries.find(params[:entry_id])
    @colleagues = User.where.not(id: current_user.id).order(email: :asc)
    @users_to_share = User.where(id: params[:colleagues_id])

    @users_to_share.each do |user|
      Share.create_or_find_by(entry: @entry, user: user)
    end
    flash.now[:notice] = "#{@entry.name} was successfully shared."
    render turbo_stream: [
      turbo_stream.update("share_with_colleagues", partial: "entries/colleagues", locals: { entry: @entry, colleagues: @colleagues })
    ]
  end

  private
  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
  def entry_params
    params.expect(entry: [ :name, :url, :username, :password ])
  end
end
