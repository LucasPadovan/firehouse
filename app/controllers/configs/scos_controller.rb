class Configs::ScosController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource

  layout ->(c) { c.request.xhr? ? false : 'application' }

  # GET /scos
  # GET /scos.json
  def index
    @title = t('view.scos.index_title')
    @scos = Sco.order('current DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scos }
    end
  end

  # GET /scos/1
  # GET /scos/1.json
  def show
    @title = t('view.scos.show_title')
    @sco = Sco.find(params[:id])

    render partial: 'show', content_type: 'text/html'
  end

  # GET /scos/new
  # GET /scos/new.json
  def new
    @title = t('view.scos.new_title')
    @sco = Sco.new

    render partial: 'new', content_type: 'text/html'
  end

  # GET /scos/1/edit
  def edit
    @title = t('view.scos.edit_title')
    @sco = Sco.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /scos
  # POST /scos.json
  def create
    @title = t('view.scos.new_title')
    @sco = Sco.new(params[:sco])

    if @sco.save
      render partial: 'sco', locals: { sco: @sco }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /scos/1
  # PUT /scos/1.json
  def update
    @title = t('view.scos.edit_title')
    @sco = Sco.find(params[:id])

      if @sco.update_attributes(params[:sco])
        render partial: 'sco', locals: { sco: @sco }, content_type: 'text/html'
      else
        render partial: 'edit', status: :unprocessable_entity
      end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_configs_sco_url(@sco), alert: t('view.scos.stale_object_error')
  end

  # DELETE /scos/1
  # DELETE /scos/1.json
  def destroy
    @sco = Sco.find(params[:id])
    @sco.destroy

    render nothing: true, content_type: 'text/html'
  end

  def activate
    sco = Sco.find(params[:id])
    notice = sco.activate! ? 
      t('view.scos.activated') : 
      t('view.scos.stale_object_error')

    respond_to do |format|
      format.html { redirect_to :back, notice: notice }
    end
  end

  def mini_index
    @title = t('view.scos.index_title')
    @scos = Sco.order('current DESC')

    respond_to do |format|
      format.html 
    end
  end
end
