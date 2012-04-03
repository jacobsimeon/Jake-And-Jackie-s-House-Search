module ApplicationHelper
  def stripe_class count
    if count.even?
      "even"
    else
      "odd"
    end
  end
end
