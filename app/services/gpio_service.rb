require 'singleton'

class GpioService
  include Singleton

  def initialize
    require 'rpi_gpio'
    RPi::GPIO.set_numbering :bcm
    @can_use = true
  rescue LoadError
    puts 'cannot load rpi_gpio module (not pi platform?)'
  end

  def on(gpio_number)
    fake_call('on', gpio_number) && return unless @can_use

    RPi::GPIO.setup gpio_number, as: :output
    RPi::GPIO.set_high gpio_number
  end

  def off(gpio_number)
    fake_call('off', gpio_number) && return unless @can_use

    RPi::GPIO.setup gpio_number, as: :output
    RPi::GPIO.set_low gpio_number
  end

  def swap(attrs)
    gpio_number = attrs['gpio_number']
    fake_call('swap', gpio_number) && return unless @can_use

    pin = Pin.find_by(gpio: gpio_number)
    if pin.state.equal?(1)
      pin.state = 0
      off gpio_number
    else
      pin.state = 1
      on gpio_number
    end
    pin.save!
  end

  private

  def fake_call(method, gpio_number)
    print 'fake call method ', method, ' with ', gpio_number
    true
  end

  def high?(gpio_number)
    fake_call('high?', gpio_number) && return unless @can_use

    RPi::GPIO.setup gpio_number, as: :input
    RPi::GPIO.high? gpio_number
  end

  def low?(_gpio_numner)
    fake_call('low?', gpio_number) && return unless @can_use

    RPi::GPIO.setup gpio_number, as: :input
    RPi::GPIO.low? gpio_number
  end
end
