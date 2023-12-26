class SeriesSchedulerJob < ApplicationJob
  queue_as :default
  after_perform :schedule_next

  def perform(series_id)
    ActionService.new.execute_series(series_id)
  end

  private

  def schedule_next
    ActionService.new.schedule_series_as_interval(arguments.first)
  end
end
