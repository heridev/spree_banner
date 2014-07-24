class AddHoverColorToSpreeBannerBoxes < ActiveRecord::Migration
  def change
    add_column :spree_banner_boxes, :hover_color, :string
  end
end
