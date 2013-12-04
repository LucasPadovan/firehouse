class UsersController < ApplicationController
  before_filter :load_current_user, only: [:edit_profile, :update_profile]
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @title = t 'view.users.index_title'
    @searchable = true
    @users = @users.filtered_list(params[:q]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js   # index.js.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title = t 'view.users.show_title'

    render partial: 'show', content_type: 'text/html'
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @title = t 'view.users.new_title'

    render partial: 'new', content_type: 'text/html'
  end

  # GET /users/1/edit
  def edit
    @title = t 'view.users.edit_title'
    #@user = User.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /users
  # POST /users.json
  def create
    @title = t 'view.users.new_title'

    if @user.save
      render partial: 'user', locals: { user: @user }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    authorize! :assign_roles, @user if params[:user] && params[:user][:roles]
    @title = t 'view.users.edit_title'

    if @user.update_attributes(params[:user])
      render partial: 'user', locals: { user: @user }, content_type: 'text/html'
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    flash.alert = t 'view.users.stale_object_error'
    redirect_to edit_user_url(@user)
  end
  
  # GET /users/1/edit_profile
  def edit_profile
    @title = t('view.users.edit_profile')
  end
  
  # PUT /users/1/update_profile
  # PUT /users/1/update_profile.xml
  def update_profile
    @title = t('view.users.edit_profile')
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(edit_profile_user_url(@user), notice: t('view.users.profile_correctly_updated')) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit_profile' }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
      end
    end

  rescue ActiveRecord::StaleObjectError
    flash.alert = t('view.users.stale_object_error')
    redirect_to edit_profile_user_url(@user)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    render nothing: true, content_type: 'text/html'
  end

  def autocomplete_for_hierarchy_name
    hierarchies = Hierarchy.filtered_list(params[:q]).limit(5)

    respond_to do |format|
      format.json { render json: hierarchies }
    end
  end
  
  private
  
  def load_current_user
    @user = current_user
  end
end
