class PeopleController < ApplicationController
  before_filter :assign_intervention
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource

  def new
    @title = t('view.people.modal.involved_person')
    @person = (@building || @vehicle).people.build
    @type = @building || @vehicle

    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @title = t('view.people.modal.involved_person')
    @person = Person.find(params[:id])
    @type = @building || @vehicle

    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @title = t('view.people.modal.involved_person')
    @person = @building.people.build(params[:person]) if @building
    @person = @vehicle.people.build(params[:person]) if @vehicle

    if @person.save
      js_notify message: t('view.people.correctly_created'),
                type: 'alert-info js-notify-18px-text', time: 2500
      render partial: 'mobile_interventions/person', locals: { person: @person },
             content_type: 'text/html'
    else
      @type = @building || @vehicle
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @title = t('view.people.modal.involved_person')
    @person = Person.find(params[:id])

    if @person.update_attributes(params[:person])
      js_notify message: t('view.people.correctly_updated'),
                type: 'alert-info js-notify-18px-text', time: 2500
      render partial: 'mobile_interventions/person', locals: { person: @person },
             content_type: 'text/html'
    else
      @type = @building || @vehicle
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to [
      'edit', @intervention, @endowment, 'mobile_intervention',
      (@vehicle || @building), @person
    ], alert: t('view.people.stale_object_error')
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    js_notify message: t('view.people.correctly_destroyed'),
              type: 'alert-danger js-notify-18px-text', time: 2500
    render nothing: true, content_type: 'text/html'
  end

  private

    def assign_intervention
      @endowment = Endowment.find(params[:endowment_id])
      @mobile_intervention = @endowment.mobile_intervention
      @intervention = @endowment.intervention

      if b_id = params[:building_id]
        @building = @mobile_intervention.buildings.find(b_id)
      end

      if v_id = params[:vehicle_id]
        @vehicle = @mobile_intervention.vehicles.find(v_id)
      end
    end
end
