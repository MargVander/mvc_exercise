# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @categories = Category.all
      @users = User.all
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      @item = Item.find(params["id"])
      @item.update(discount_percentage: params["item"]["discount_percentage"], has_discount: true)
      puts Item.average_price.round(2)

      redirect_to administration_items_path
    end
  end
end
