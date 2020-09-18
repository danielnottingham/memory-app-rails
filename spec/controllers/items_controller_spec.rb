require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  context 'GET #new' do
    it 'should success render new' do
      get :new
      expect(response).to have_http_status(200)
      expect(assigns(:item)).to be_a(Item)
    end
  end

  context 'POST #create' do
    item_attributes = FactoryBot.attributes_for(:item)
    it 'create a new item' do
      expect { post :create, params: item_attributes }.to change(Item, :count).from(0).to(1)
      expect(response).to redirect_to(action: :index)
    end

    it 'not create a new item' do
      item_attributes = { key: 'Sara' }
      expect { post :create, params: item_attributes }.to_not change(Item, :count)
      expect(assigns(:item).errors.full_messages).to eq(["Value can't be blank", 'Value is invalid'])
      expect(response).to render_template(:new)
    end
  end

  context 'GET #edit' do
    let!(:item) { create(:item) }

    it 'should success render edit' do
      get :edit, params: { id: item.id }
      expect(response).to render_template(:edit)
      expect(assigns(:item)).to be_a(Item)
    end
  end

  context 'PUT #update' do
    let!(:item) { create(:item) }

    it 'should update item info' do
      params = { key: 'Edimo' }

      put :update, params: { id: item.id, key: 'Edimo' }
      item.reload
      expect(item.key).to eq(params[:key])
      expect(response).to redirect_to(action: :index)
    end

    it 'should not update item info' do
      params = { key: nil }
      put :update, params: { id: item.id, key: nil }
      item.reload
      expect(item.key).to_not be_nil
      expect(assigns(:item).errors.full_messages).to eq(["Key can't be blank", 'Key is invalid'])
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
      expect(assigns(:items)).to be_empty
    end

    it 'should have at least one item' do
      create(:item)
      get :index
      expect(assigns(:items)).to_not be_empty
    end
  end

  context 'DELETE #destroy' do
    let!(:item) { create(:item) }

    it 'should delete item' do
      expect { delete :destroy, params: { id: item.id } }.to change(Item, :count).from(1).to(0)
      expect(response).to redirect_to(action: :index)
    end
  end

  context 'finds a searched item by key' do
    #prepare
    let!(:item) { create(:item, key: 'Daniel') }
    let!(:item1) { create(:item, key: 'Edimo') }
    let!(:item2) { create(:item, key: 'Edmilson') }

    it 'finds by key Ed' do
      #action
      get :index, params: { search_by_key: 'Ed' }
      #assert
      assigns(:items).should eq([item1, item2])
    end

    it 'finds by key with da' do
      #action
      get :index, params: { search_by_key: 'Da' }
      #assert
      assigns(:items).should eq([item])
    end

    it 'finds by key with iel' do
      #action
      get :index, params: { search_by_key: 'iel' }
      #assert
      assigns(:items).should eq([item])
    end

    it 'when does not find any items' do
      #action
      get :index, params: { search_by_key: 'f' }
      #assert
      expect(nil).to be_nil
    end

    it 'when search is empty' do
      #action
      get :index, params: { search_by_key: ' ' }
      #assert
      expect(assigns(:items)).to be_empty
    end
  end
end
