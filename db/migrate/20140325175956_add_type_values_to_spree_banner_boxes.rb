class AddTypeValuesToSpreeBannerBoxes < ActiveRecord::Migration
  def change
    add_column :spree_banner_boxes, :banner_type, :string
    add_column :spree_banner_boxes, :text_lines, :text
    add_column :spree_banner_boxes, :text_button, :string
    add_column :spree_banner_boxes, :bg_color, :string
  end
end
