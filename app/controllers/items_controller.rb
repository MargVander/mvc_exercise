# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.all
  end
end
