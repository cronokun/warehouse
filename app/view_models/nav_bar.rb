class NavBar
  include ActionView::Helpers::OutputSafetyHelper,
          ActionView::Helpers::TagHelper,
          ActionView::Helpers::UrlHelper

  delegate :url_helpers, to: 'Rails.application.routes'


  NavBarItem = Struct.new(:name, :url)

  attr_accessor :items
  attr_reader :navbar_class, :active_item_class, :request

  def initialize(opts = {})
    @items = []
    @request = opts[:request]
    @navbar_class = opts[:navbar_class] || "nav navbar-nav"
    @active_item_class = opts[:active_item_class] || "active"
  end

  def item(name, url)
    @items.push NavBarItem.new(name, url)
    puts ">" * 80
    puts url.inspect
  end

  def self.render(opts = {})
    navbar = self.new(opts)
    yield navbar if block_given?
    navbar.render_menu
  end

  def render_menu
    content_tag :ul, safe_join(menu_items), class: navbar_class
  end

  private

  def menu_items
    items.map do |item|
      content_tag :li, link_to_item(item), class: active_section?(item) ? active_item_class : nil
    end
  end

  def link_to_item(item)
    link_to item.name, item.url
  end

  def active_section?(item)
    Regexp.new(item.url).match(request.fullpath)
  end
end
