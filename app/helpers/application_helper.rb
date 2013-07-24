module ApplicationHelper

  def full_title
    base_title = "Challenge Rails"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
