class ApplicationController < ActionController::Base
  before_action :init_team, if: :user_signed_in?
  before_action :set_working_team, if: :user_signed_in?

  def change_keep_team(user, current_team)
    user.keep_team_id = current_team.id
    user.save!
  end

  def ensure_current_user_agenda_check
    if current_user.id != @agenda.team.owner_id && current_user.id != @agenda.user_id
      redirect_to dashboard_url, notice: I18n.t('views.messages.no_authorized_to_do_this')
    end
  end

  def ensure_current_user_team_check
    unless current_user.id == @team.owner_id
      redirect_to team_url(@team.id), notice: I18n.t('views.messages.no_authorized_to_do_this')
    end
  end

  private

  def set_working_team
    @working_team = current_user.keep_team_id ? Team.find(current_user.keep_team_id) : Team.first
  end

  def init_team
    current_user.assigns.create!(team_id: Team.first.id) if current_user.teams.blank?
  end
end
