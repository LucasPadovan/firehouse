class InterventionsController < ApplicationController
  before_filter :authenticate_user!
  
  check_authorization
  load_and_authorize_resource
  
  # GET /interventions
  # GET /interventions.json
  def index
    @title = t('view.interventions.index_title')
    @interventions = Intervention.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interventions }
    end
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
    @title = t('view.interventions.show_title')
    @intervention = Intervention.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @intervention }
    end
  end

  # GET /interventions/new
  # GET /interventions/new.json
  def new
    @title = t('view.interventions.new_title')
    @intervention = Intervention.new
    @intervention.build_informer unless @intervention.informer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @intervention }
    end
  end

  # GET /interventions/1/edit
  def edit
    @title = t('view.interventions.edit_title')
    @intervention = Intervention.find(params[:id])
  end

  # POST /interventions
  # POST /interventions.json
  def create
    @title = t('view.interventions.new_title')
    @intervention = Intervention.new(params[:intervention])

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to @intervention, notice: t('view.interventions.correctly_created') }
        format.json { render json: @intervention, status: :created, location: @intervention }
      else
        format.html { render action: 'new' }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /interventions/1
  # PUT /interventions/1.json
  def update
    @title = t('view.interventions.edit_title')
    @intervention = Intervention.find(params[:id])

    respond_to do |format|
      if @intervention.update_attributes(params[:intervention])
        format.html { redirect_to @intervention, notice: t('view.interventions.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_intervention_url(@intervention), alert: t('view.interventions.stale_object_error')
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention = Intervention.find(params[:id])
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url }
      format.json { head :ok }
    end
  end

  def autocomplete_for_truck_number
    trucks = Truck.filtered_list(params[:q]).limit(5)

    respond_to do |format|
      format.json { render json: trucks }
    end
  end
end