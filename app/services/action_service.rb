class ActionService
  def execute(id)
    a = Action.find(id)
    service_name = "#{a.service}Service"
    service = service_name.classify.safe_constantize
    method = a.params['method']
    attrs = a.params['attrs']
    service.instance.send(method, attrs)
  end

  def schedule_as_interval(id)
    action = Action.find(id)
    wait = action.timer.value.to_i
    ActionSchedulerJob.set(wait: wait.seconds).perform_later(action.id)
  end

  def execute_series(id)
    s = Series.find(id)
    s.actions.each { |a| execute(a.id) }
  end

  def schedule_series_as_interval(id)
    series = Series.find(id)
    wait = series.timer.value.to_i
    SeriesSchedulerJob.set(wait: wait.seconds).perform_later(series.id)
  end
end
