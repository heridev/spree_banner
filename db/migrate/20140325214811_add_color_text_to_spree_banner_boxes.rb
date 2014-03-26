class AddColorTextToSpreeBannerBoxes < ActiveRecord::Migration
  def change
    add_column :spree_banner_boxes, :text_color, :string
  end
end
