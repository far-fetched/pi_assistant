class ActionsController < ApplicationController
  def execute
    a = Action.find(permit_params[:id])

    service_name = "#{a.service}Service"
    service = service_name.classify.safe_constantize
    method = a.params['method']
    attrs = a.params['attrs']
    service.instance.send(method, attrs)
    redirect_to new_action_path
  end

  def new
    @services = %w[gpio i2c]
    @actions = Action.all

    if permit_params[:service]
      redirect_to "/#{permit_params[:service]}/new"
    end
  end

  def destroy
    @action = Action.find(permit_params[:id])
    @action.destroy
  end

  private

  def action_params
    params.require(:model).permit(:gpio_number, :command, :service)
  end

  def permit_params
    params.permit(:id, :service)
  end
end
