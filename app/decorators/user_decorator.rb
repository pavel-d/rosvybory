class UserDecorator < Draper::Decorator
  delegate_all
  delegate :can_be_caller, :can_be_coord_region, :can_be_mobile, :human_current_roles, :extra,
           :experience_count, :full_name, :human_has_car, :human_has_video, :human_legal_status,
           :human_previous_statuses, :human_social_accounts, :uic,
            to: :decorated_user_app, allow_nil: true

  def user_current_roles
    ucrs = []
    object.user_current_roles.each do |ucr|
      ucrs << h.user_current_role_human_readable(ucr)
    end
    ucrs.join("; ")
  end

  def decorated_user_app
    user_app.try(:decorate)
  end

  def human_roles
    #user.roles.collect(&:short_name).to_sentence
    object.roles.pluck(:short_name).join("; ")
  end



end