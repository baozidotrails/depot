module ApplicationHelper
  def date_loaded(format)
    time = Time.now
    time.to_formatted_s format
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success',
      info:    'alert-info',
      error:   'alert-danger',
      warning: 'alert-warning' }[flash_type.to_sym] || flash_type.to_s
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
end
