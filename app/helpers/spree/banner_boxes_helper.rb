module Spree
  module BannerBoxesHelper

    def insert_banner_box(params={})
      params[:category] ||= "home"
      params[:class] ||= "banner"
      params[:style] ||= SpreeBanner::Config[:banner_default_style]
      params[:list] ||= false
      banners = Spree::BannerBox.enabled(params[:category]).order(:position)
      return '' if banners.empty?

      if params[:list]
        content_tag :ul do
          banners.map do |ban|
            content_tag :li, :class => params[:class] do
              link_to (ban.url.blank? ? "javascript: void(0)" : ban.url) do
                src = ban.attachment.url(params[:style].to_sym)
                image_tag(src, :alt => ban.alt_text.presence || image_alt(src))
              end
            end
          end.join.html_safe
        end
      else
        banners.map do |ban|
          content_tag :div, :class => params[:class] do
            link_to (ban.url.blank? ? "javascript: void(0)" : ban.url) do
              src = ban.attachment.url(params[:style].to_sym)
              image_tag(ban.attachment.url(params[:style].to_sym), :alt => ban.alt_text.presence || image_alt(src))
            end
          end
        end.join.html_safe
      end
    end

    def insert_banner_box_by_name name, style
      banner = Spree::BannerBox.find_by_category_name(name)
      link_to (banner.url.blank? ? "javascript: void(0)" : banner.url) do
        src = banner.attachment.url(style.to_sym)
        image_tag(banner.attachment.url(style.to_sym), :alt => banner.alt_text.presence || image_alt(src))
      end
    end

    def image_category_link name, style
      banner = Spree::BannerBox.find_by_category_name(name)
      link_to (edit_box_by_category_admin_banner_boxes_path(name: name)) do
        src = banner.attachment.url(style.to_sym)
        image_tag(banner.attachment.url(style.to_sym), :alt => banner.alt_text.presence || image_alt(src))
      end
    end
  end
end

