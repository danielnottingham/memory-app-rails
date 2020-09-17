class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy, :edit, :update]

  def index
    @items = Item.all
    if params[:search_by_key]
      @items = Item.search_by_key(params[:search_by_key])
    else
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to action: 'index'
  end

  def destroy
    @item.destroy
    redirect_to action: 'index'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(:key, :value)
  end
end
