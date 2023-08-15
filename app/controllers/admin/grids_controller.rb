module Admin
  class GridsController < BaseController
    def show
    end

    def data
      @items = Item.includes(:borrow_policy, :category_nodes, :rich_text_description)
    end
  end
end
