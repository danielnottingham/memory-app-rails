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
    let!(:params) do
      {
        'item' => item_attributes
      }
    end
    let!(:params2) do
      {
        'item' => { key: 'Sara', value: nil }
      }
    end
    it 'create a new item' do
      expect { post :create, params: params }.to change(Item, :count).from(0).to(1)
      expect(response).to redirect_to(action: :index)
    end

    it 'not create a new item' do
      expect { post :create, params: params2 }.to_not change(Item, :count)
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
    let!(:params) do
      {
        'item' => { key: 'Edimo', value: 'Sousa', visible: true },
        'id' => item.id
      }
    end
    let!(:params2) do
      {
        'item' => { key: nil, value: 'Sousa', visible: true },
        'id' => item.id
      }
    end

    it 'should update item info' do
      put :update, params: params
      item.reload
      expect(item.key).to eq('Edimo')
      expect(response).to redirect_to(action: :index)
    end

    it 'should not update item info' do
      put :update, params: params2
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
