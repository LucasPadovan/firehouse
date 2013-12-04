class Configs::TrucksController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource

  # GET /trucks
  # GET /trucks.json
  def index
    @title = t('view.trucks.index_title')
    @trucks = Truck.filtered_list(params[:q]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trucks }
    end
  end

  # GET /trucks/1
  # GET /trucks/1.json
  def show
    @title = t('view.trucks.show_title')
    @truck = Truck.find(params[:id])

    render partial: 'show', content_type: 'text/html'
  end

  # GET /trucks/new
  # GET /trucks/new.json
  def new
    @title = t('view.trucks.new_title')
    @truck = Truck.new

    render partial: 'new', content_type: 'text/html'
  end

  # GET /trucks/1/edit
  def edit
    @title = t('view.trucks.edit_title')
    @truck = Truck.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /trucks
  # POST /trucks.json
  def create
    @title = t('view.trucks.new_title')
    @truck = Truck.new(params[:truck])

    if @truck.save
      render partial: 'truck', locals: { truck: @truck }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /trucks/1
  # PUT /trucks/1.json
  def update
    @title = t('view.trucks.edit_title')
    @truck = Truck.find(params[:id])

    if @truck.update_attributes(params[:truck])
      render partial: 'truck', locals: { truck: @truck }, content_type: 'text/html'
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_truck_url(@truck), alert: t('view.trucks.stale_object_error')
  end

  # DELETE /trucks/1
  # DELETE /trucks/1.json
  def destroy
    @truck = Truck.find(params[:id])
    @truck.destroy

    render nothing: true, content_type: 'text/html'
  end
end
