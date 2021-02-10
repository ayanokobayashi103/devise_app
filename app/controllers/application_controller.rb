class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #　独自で追加したカラムがある場合は追加で記述をする必要があるsign up時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # update際の記述
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
