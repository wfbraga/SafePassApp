module FlashHelper
  def flash_class(type)
    type = type.to_sym
    case type
      when :notice then "info"
      when :success then "success"
      when :error then "danger"
      when :alert then "danger"
    end
  end
end