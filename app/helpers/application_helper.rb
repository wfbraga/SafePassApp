module ApplicationHelper
  def logo(size='h2')
    link_to root_path, class: "logo #{size}" do
      "<i class=\"bi bi-safe-fill me-2\"></i> Safe Pass App".html_safe
    end
  end

  def account_page?
    current_page?(user_registration_path) || current_page?(edit_user_registration_path)
  end

  def format_time(time)
    time.strftime("%B %d, %Y at %I:%M %p")
  end

  def render_flash_messages
    turbo_stream.update "flash", partial: "shared/flash"
  end
end
