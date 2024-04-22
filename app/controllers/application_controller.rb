class ApplicationController < ActionController::Base
  include Authentication
  around_action :switch_locale

  private
  def default_url_options
    { locale: I18n.locale }
  end
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

end
