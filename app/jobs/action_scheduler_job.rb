class ActionSchedulerJob < ApplicationJob
  queue_as :default
  after_perform :schedule_next

  def perform(action_id)
    ActionService.new.execute(action_id)
  end

  private

  def schedule_next
    ActionService.new.schedule_as_interval(arguments.first)
  end
end
