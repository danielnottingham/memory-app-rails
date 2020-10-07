class ItemsController < ApplicationController
  before_action :set_item, only: %i[destroy edit update]

  def index
    @items = Item.all
    @items = if params[:search_by_key]
               Item.search_by_key(params[:search_by_key])
             else
               Item.all
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

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to action: 'index'
    else
      render :edit
    end
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
    params.require(:item).permit(:key, :value, :visible)
  end
end
