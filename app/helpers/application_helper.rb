module ApplicationHelper
  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end

  def user_avatar(user)
    user&.avatar.present? ? user.avatar.url : asset_path('avatar.png')
  end

  def subscribed?(event)
    event.subscribers.include?(current_user) || event.user == current_user
  end
end
