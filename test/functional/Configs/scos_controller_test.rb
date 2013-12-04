require 'test_helper'

class Configs::ScosControllerTest < ActionController::TestCase

  setup do
    @sco = Fabricate(:sco)
    @user = Fabricate(:user)
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:scos)
    assert_select '#unexpected_error', false
    assert_template 'configs/scos/index'
  end

  test 'should get new' do
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:sco)
    assert_select '#unexpected_error', false
    assert_template 'configs/scos/_new'
  end

  test 'should create sco' do
    assert_difference('Sco.count') do
      xhr :post, :create, sco: Fabricate.attributes_for(:sco)
    end

    assert_response :success
    assert_not_nil assigns(:sco)
    assert_select '#unexpected_error', false
    assert_template 'configs/scos/_sco'
  end

  test 'should no create sco' do
    assert_no_difference('Sco.count') do
      xhr :post, :create, sco: { }
    end

    assert_response :unprocessable_entity
    assert_not_nil assigns(:sco)
    assert_template 'configs/scos/_new'
    assert_select '#unexpected_error', false
    assert_select '.alert-error', true
  end

  test 'should show sco' do
    xhr :get, :show, id: @sco
    assert_response :success
    assert_not_nil assigns(:sco)
    assert_select '#unexpected_error', false
    assert_template 'configs/scos/_show'
  end

  test 'should get edit' do
    xhr :get, :edit, id: @sco
    assert_response :success
    assert_not_nil assigns(:sco)
    assert_select '#unexpected_error', false
    assert_template 'configs/scos/_edit'
  end

  test 'should update sco' do
    xhr :put, :update, id: @sco,
      sco: Fabricate.attributes_for(:sco)
    assert_response :success
    assert_not_nil assigns(:sco)
    assert_template 'configs/scos/_sco'
    assert_select '#unexpected_error', false
  end

  test 'should not update sco' do
    xhr :put, :update, id: @sco, sco: { full_name: '' }

    assert_response :unprocessable_entity
    assert_not_nil assigns(:sco)
    assert_template 'configs/scos/_edit'
    assert_select '#unexpected_error', false
    assert_select '.alert-error', true
  end

  test 'should destroy sco' do
    assert_difference('Sco.count', -1) do
      xhr :delete, :destroy, id: @sco
    end

    assert_response :success
  end
end
