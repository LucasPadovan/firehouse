class PeopleController < ApplicationController
  before_filter :get_intervention

  def index
    @title = t('view.people.index_title')
    @people = Person.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show
    @title = t('view.people.show_title')
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def new
    @title = t('view.people.new_title')
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @title = t('view.people.edit_title')
    @person = Person.find(params[:id])
  end

  def create
    @title = t('view.people.new_title')
    @person = @building.persons.build(params[:person]) if @building
    @person = @vehicle.persons.build(params[:person]) if @vehicle

    respond_to do |format|
      if @person.save
        format.html { redirect_to [@intervention, @mobile_intervention], notice: t('view.people.correctly_created') }
        format.json { render json: [@intervention, @mobile_intervention], status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @title = t('view.people.edit_title')
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to [@intervention, @mobile_intervention], notice: t('view.people.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to ['edit',@intervention, @mobile_intervention, @building, @person], alert: t('view.people.stale_object_error')
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to [@intervention, @mobile_intervention] }
      format.json { head :ok }
    end
  end

  private
    def get_intervention
      @intervention = Intervention.includes(:mobile_intervention).find(params[:intervention_id])
      @mobile_intervention = @intervention.mobile_intervention
      @building = Building.find(params[:building_id]) if params[:building_id]
      @vehicle = Vehicle.find(params[:vehicle_id]) if params[:vehicle_id]
    end
end
