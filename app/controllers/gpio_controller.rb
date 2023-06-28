class GpioController < ApplicationController
  def new
    @commands = %w(on off swap)
  end

  def create
    params = {
      method: action_params[:command],
      attrs: {
        gpio_number: action_params[:gpio_number]
      }
    }
    @action = Action.new(service: 'gpio', params: params)

    respond_to do |format|
      if @action.save
        format.turbo_stream
      end
    end
  end

  private

  def action_params
    params.permit(:gpio_number, :command, :service)
  end
end
