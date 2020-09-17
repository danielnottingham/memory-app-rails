require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context 'GET #new' do
    it 'should success render new' do
      get :new
      expect(response).to have_http_status(200)
      expect(assigns(:user)).to be_a(User)
    end
  end

  context 'POST #create' do
    user_attributes = FactoryBot.attributes_for(:user)
    it 'create a new user' do
      expect { post :create, params: user_attributes }.to change(User, :count).from(0).to(1)
      expect(response).to redirect_to(action: :index)
    end

    it 'not create a new user' do
      user_attributes = { name: 'Sara' }
      expect { post :create, params: user_attributes }.to_not change(User, :count)
      expect(assigns(:user).errors.full_messages).to eq(["Phone can't be blank", 'Phone is not a number'])
      expect(response).to render_template(:new)
    end
  end

  context 'GET #edit' do
    let!(:user) { create(:user) }

    it 'should success render edit' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
      expect(assigns(:user)).to be_a(User)
    end
  end

  context 'PUT #update' do
    let!(:user) { create(:user) }

    it 'should update user info' do
      params = { name: 'Edimo' }

      put :update, params: { id: user.id, name: 'Edimo' }
      user.reload
      expect(user.name).to eq(params[:name])
      expect(response).to redirect_to(action: :index)
    end

    it 'should not update user info' do
      params = { name: nil }
      put :update, params: { id: user.id, name: nil }
      user.reload
      expect(user.name).to_not be_nil
      expect(assigns(:user).errors.full_messages).to eq(["Name can't be blank", 'Name is invalid'])
      expect(response).to render_template(:edit)
    end
  end

  context 'GET #index' do
    it 'should success and render to index page' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'should have a array empty' do
      get :index
      expect(assigns(:users)).to be_empty
    end

    it 'should have at least one user' do
      create(:user)
      get :index
      expect(assigns(:users)).to_not be_empty
    end
  end

  context 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'should delete user' do
      expect { delete :destroy, params: { id: user.id } }.to change(User, :count).from(1).to(0)
      expect(response).to redirect_to(action: :index)
    end
  end

  context 'finds a searched user by name' do
    #prepare
    let!(:user) { create(:user, name: 'Daniel') }
    let!(:user1) { create(:user, name: 'Edimo') }
    let!(:user2) { create(:user, name: 'Edmilson') }

    it 'finds by name Ed' do
      #action
      get :index, params: { search_by_name: 'Ed' }
      #assert
      assigns(:users).should eq([user1, user2])
    end

    it 'finds by name with da' do
      #action
      get :index, params: { search_by_name: 'Da' }
      #assert
      assigns(:users).should eq([user])
    end

    it 'finds by name with iel' do
      #action
      get :index, params: { search_by_name: 'iel' }
      #assert
      assigns(:users).should eq([user])
    end

    it 'when does not find any user' do
      #action
      get :index, params: { search_by_name: 'f' }
      #assert
      expect(nil).to be_nil
    end

    it 'when search is empty' do
      #action
      get :index, params: { search_by_name: ' ' }
      #assert
      expect(assigns(:users)).to be_empty
    end
  end
end
