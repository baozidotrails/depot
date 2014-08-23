module ApplicationHelper
  def date_loaded(format)
    time = Time.now
    time.to_formatted_s format
  end
end
