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
      if banner && banner.banner_type
        send("banner_type_#{banner.banner_type}", banner, style)
      end
    end

    def get_color_banner name
      banner = Spree::BannerBox.find_by_category_name(name)
      banner && banner.bg_color != '' && banner.bg_color || 'FCFCFC'
    end

    def get_banner_link name
      banner = Spree::BannerBox.find_by_category_name(name)
      banner.try(:url)
    end

    def visible_div banner_type, type
      "style='display: none'".html_safe if banner_type == type
    end

    def banner_type_text banner, size
      text_button = banner.text_button != '' && banner.text_button
      text_color = banner.text_color != '' && banner.text_color || '000000'

      style, hr_element, lines = select_banner_size banner, size

      content_tag(:div, class: "text-banner #{size}", style: style) do
        lines.each_with_index do |line, index|
          concat content_tag(:p, line, class: "line-number-#{index + 1}")
        end
        concat hr_element
        concat link_to text_button,
          banner.url, class: 'custom-button',
          style: "border: 1px solid ##{text_color}; color: ##{text_color};" if text_button
      end
    end

    def select_banner_size banner, size
      bg_color = banner.bg_color != '' && banner.bg_color || 'FCFCFC'
      text_color = banner.text_color != '' && banner.text_color || '000000'
      lines = (banner.text_lines && banner.text_lines.split("\r\n")) || ['', '', '']
      hr_element = ''
      style = ''

      case size
      when 'small'
        style = "width: 100%; height: 100%; position: absolute; background: ##{bg_color}; color: ##{text_color}; padding-top: 63px;"
      when 'medium'
        style = "width: 50%; height: 100%; position:absolute; background: ##{bg_color}; color: ##{text_color}"
        hr_element = content_tag(:hr) if lines[0] != ''
      else
        style = "width: 323px; height: 320px; background: ##{bg_color}; color: ##{text_color}"
      end

      return style, hr_element, lines
    end

    def banner_type_photo banner, style
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

