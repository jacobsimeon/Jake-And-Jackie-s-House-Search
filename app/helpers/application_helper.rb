module ApplicationHelper
  def stripe_class count
    if count.even?
      "even"
    else
      "odd"
    end
  end

  def navigation_link_for(list)
    list_options = {}
    list_options[:class] = "active" if list == @list
    content_tag(:li, list_options) do
      link_to list.friendly_name, list_path(list)
    end
  end

end
