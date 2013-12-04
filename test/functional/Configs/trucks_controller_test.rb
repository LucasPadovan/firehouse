require 'test_helper'

class Configs::TrucksControllerTest < ActionController::TestCase

  setup do
    @truck = Fabricate(:truck)
    @user = Fabricate(:user)
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:trucks)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/index'
  end

  test 'should get new' do
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_new'
  end

  test 'should create truck' do
    assert_difference('Truck.count') do
      xhr :post, :create, truck: Fabricate.attributes_for(:truck)
    end
    assert_response :success
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_truck'
  end

  test 'should not create truck' do
    assert_no_difference('Truck.count') do
      xhr :post, :create, truck: {}
    end
    assert_response :unprocessable_entity
    assert_not_nil assigns(:truck)
    assert_template 'configs/trucks/_new'
    assert_select '#unexpected_error', false
    assert_select '.alert-error', true
  end

  test 'should show truck' do
    xhr :get, :show, id: @truck
    assert_response :success
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_show'
  end

  test 'should get edit' do
    xhr :get, :edit, id: @truck
    assert_response :success
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_edit'
  end

  test 'should update truck' do
    xhr :put, :update, id: @truck,
      truck: Fabricate.attributes_for(:truck)
    assert_response :success
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_truck'
  end

  test 'should not update truck' do
    xhr :put, :update, id: @truck,
      truck: { number: '' }
    assert_response :unprocessable_entity
    assert_not_nil assigns(:truck)
    assert_select '#unexpected_error', false
    assert_template 'configs/trucks/_edit'
    assert_select '.alert-error', true
  end

  test 'should destroy truck' do
    assert_difference('Truck.count', -1) do
      xhr :delete, :destroy, id: @truck
    end

    assert_response :success
  end
end
