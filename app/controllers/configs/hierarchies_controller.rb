class Configs::HierarchiesController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource

  # GET /hierarchies
  # GET /hierarchies.json
  def index
    @title = t('view.hierarchies.index_title')
    @hierarchies = Hierarchy.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hierarchies }
    end
  end

  # GET /hierarchies/1
  # GET /hierarchies/1.json
  def show
    @title = t('view.hierarchies.show_title')
    @hierarchy = Hierarchy.find(params[:id])

    render partial: 'show', content_type: 'text/html'
  end

  # GET /hierarchies/new
  # GET /hierarchies/new.json
  def new
    @title = t('view.hierarchies.new_title')
    @hierarchy = Hierarchy.new


    render partial: 'new', content_type: 'text/html'
  end

  # GET /hierarchies/1/edit
  def edit
    @title = t('view.hierarchies.edit_title')
    @hierarchy = Hierarchy.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /hierarchies
  # POST /hierarchies.json
  def create
    @title = t('view.hierarchies.new_title')
    @hierarchy = Hierarchy.new(params[:hierarchy])

    if @hierarchy.save
      render partial: 'hierarchy', locals: { hierarchy: @hierarchy }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /hierarchies/1
  # PUT /hierarchies/1.json
  def update
    @title = t('view.hierarchies.edit_title')
    @hierarchy = Hierarchy.find(params[:id])

    if @hierarchy.update_attributes(params[:hierarchy])
      render partial: 'hierarchy', locals: { hierarchy: @hierarchy }, content_type: 'text/html'
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_configs_hierarchy_url(@hierarchy), alert: t('view.hierarchies.stale_object_error')
  end

  # DELETE /hierarchies/1
  # DELETE /hierarchies/1.json
  def destroy
    @hierarchy = Hierarchy.find(params[:id])
    @hierarchy.destroy

    render nothing: true, content_type: 'text/html'
  end
end
