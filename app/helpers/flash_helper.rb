module FlashHelper
  def flash_class(type)
    case level
      when :notice then "info"
      when :success then "success"
      when :error then "danger"
      when :alert then "danger"
    end
  end
end