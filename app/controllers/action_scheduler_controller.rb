class ActionSchedulerController < ApplicationController
  def create
    ActionService.new.schedule_as_interval(action_id)
    redirect_to new_action_path
  end

  private

  def action_id
    params.require(:action_id);
  end
end
