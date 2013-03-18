class SupportsController < ApplicationController
  before_filter :get_intervention

  def new
    @title = t('view.support.new_title')
    @support = Support.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @title = t('view.support.edit_title')
    @support = Support.find(params[:id])
  end

  def create
    @title = t('view.support.new_title')
    @support = @mobile_intervention.supports.build(params[:support])

    respond_to do |format|
      if @support.save
        format.html { redirect_to [@intervention, @mobile_intervention], notice: t('view.support.correctly_created') }
        format.json { render json: [@intervention, @mobile_intervention], status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @title = t('view.support.edit_title')
    @support = Support.find(params[:id])

    respond_to do |format|
      if @support.update_attributes(params[:person])
        format.html { redirect_to [@intervention, @mobile_intervention], notice: t('view.support.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to ['edit',@intervention, @mobile_intervention, @support], alert: t('view.support.stale_object_error')
  end

  def destroy
    @support = Support.find(params[:id])
    @support.destroy

    respond_to do |format|
      format.html { redirect_to [@intervention, @mobile_intervention] }
      format.json { head :ok }
    end
  end

  private
  def get_intervention
    @intervention = Intervention.includes(:mobile_intervention).find(params[:intervention_id])
    @mobile_intervention = @intervention.mobile_intervention
  end
end