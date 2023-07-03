require 'singleton'

class GpioService
  include Singleton

  def initialize
    system "python3 lib/scripts/test_is_pi_platform.py", exception: true
    @can_use = true
  rescue => e
    puts 'cannot load gpio module (not pi platform?)'
  end

  def on(attrs)
    gpio_number = attrs['gpio_number']
    fake_call('on', gpio_number) && return unless @can_use

    system "python3 lib/scripts/on.py --pin #{gpio_number}"
  end

  def off(attrs)
    gpio_number = attrs['gpio_number']
    fake_call('off', gpio_number) && return unless @can_use

    system "python3 lib/scripts/off.py --pin #{gpio_number}"
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
