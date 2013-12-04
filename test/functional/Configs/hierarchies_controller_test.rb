require 'test_helper'

class Configs::HierarchiesControllerTest < ActionController::TestCase

  setup do
    @hierarchy = Fabricate(:hierarchy)
    @user = Fabricate(:user)
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:hierarchies)
    assert_select '#unexpected_error', false
    assert_template 'configs/hierarchies/index'
  end

  test 'should get new' do
    xhr :get, :new
    assert_response :success
    assert_not_nil assigns(:hierarchy)
    assert_select '#unexpected_error', false
    assert_template 'configs/hierarchies/_new'
  end

  test 'should create hierarchy' do
    assert_difference('Hierarchy.count') do
      xhr :post, :create, hierarchy: Fabricate.attributes_for(:hierarchy)
    end

    assert_response :success
    assert_not_nil assigns(:hierarchy)
    assert_template 'configs/hierarchies/_hierarchy'
    assert_select '#unexpected_error', false
  end

  test 'should not create hierarchy with blank attributes' do
    assert_no_difference('Hierarchy.count') do
      xhr :post, :create, hierarchy: {}
    end
    assert_response :unprocessable_entity
    assert_not_nil assigns(:hierarchy)
    assert_template 'configs/hierarchies/_new'
    assert_select '#unexpected_error', false
    assert_select '.alert-error', true
  end

  test 'should show hierarchy' do
    xhr :get, :show, id: @hierarchy
    assert_response :success
    assert_not_nil assigns(:hierarchy)
    assert_select '#unexpected_error', false
    assert_template 'configs/hierarchies/_show'
  end

  test 'should get edit' do
    xhr :get, :edit, id: @hierarchy
    assert_response :success
    assert_not_nil assigns(:hierarchy)
    assert_select '#unexpected_error', false
    assert_template 'configs/hierarchies/_edit'
  end

  test 'should update hierarchy' do
    xhr :put, :update, id: @hierarchy,
      hierarchy: Fabricate.attributes_for(:hierarchy)
    assert_response :success
    assert_not_nil assigns(:hierarchy)
    assert_template 'configs/hierarchies/_hierarchy'
    assert_select '#unexpected_error', false
  end

  test 'should not update hierarchy' do
    xhr :put, :update, id: @hierarchy, hierarchy: { name: '' }

    assert_response :unprocessable_entity
    assert_not_nil assigns(:hierarchy)
    assert_template 'configs/hierarchies/_edit'
    assert_select '#unexpected_error', false
    assert_select '.alert-error', true
  end

  test 'should destroy hierarchy' do
    assert_difference('Hierarchy.count', -1) do
      xhr :delete, :destroy, id: @hierarchy
    end
    assert_response :success
  end
end
