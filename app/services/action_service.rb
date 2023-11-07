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
end
