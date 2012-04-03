module ApplicationHelper
  def stripe_class count
    if count.even?
      "even"
    else
      "odd"
    end
  end

  def navigation_link_for(section)
    list_options = {}
    list_options[:class] = "active" if section == @active_section
    content_tag(:li, list_options) do
      link_name = section.split('_').each { |s| s.capitalize! }.join(' ')
      link_to link_name, :list => section
    end
  end
end
