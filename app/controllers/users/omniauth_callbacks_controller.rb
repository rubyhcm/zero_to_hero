class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_auth 'Github'
  end

  def google_oauth2
    handle_auth 'Google'
  end

  def handle_auth(kind)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if user_persisted?
      handle_successful_authentication(kind)
    else
      handle_failed_authentication
    end
  end

  def failure
    redirect_to root_path, alert: 'Failure. Please try again'
  end

  private

  def user_persisted?
    @user.persisted?
  end

  def handle_successful_authentication(kind)
    flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind:)
    sign_in_and_redirect @user, event: :authentication
  end

  def handle_failed_authentication
    session['devise.auth_data'] = request.env['omniauth.auth'].except(:extra)
    redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
  end
end
