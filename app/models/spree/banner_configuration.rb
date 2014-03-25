module Spree
  class BannerConfiguration < Preferences::Configuration
    preference :banner_default_url, :string, default: '/spree/banners/:id/:style/:basename.:extension'
    preference :banner_path, :string, default: ':rails_root/public/spree/banners/:id/:style/:basename.:extension'
    preference :banner_url, :string, default: '/spree/banners/:id/:style/:basename.:extension'
    preference :banner_styles, :string, default: "{\"double\":\"640x320>\",\"big_right\":\"320x640>\",\"small\":\"320x160>\",\"medium\":\"320x321#\"}"
    preference :banner_default_style, :string, default: 'small'
  end
end
