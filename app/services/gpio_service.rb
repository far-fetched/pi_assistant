require 'singleton'

class GpioService
  include Singleton

  def initialize
    system 'python3 lib/scripts/test_is_pi_platform.py', exception: true
    @can_use = true
  rescue StandardError => e
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

  def rising_edge(attrs)
    unless @can_use then
      fake_call('off', attrs)
      fake_call('on', attrs)
      return
    end

    gpio_number = attrs['gpio_number']
    off gpio_number
    sleep(0.005.seconds)
    on gpio_number

    #repeat_number = attrs['repeat_number']
    #system "python3 lib/scripts/motor.py --step #{repeat_number}"
  end

  def falling_edge

  end

  private

  def fake_call(method, gpio_number)
    puts 'fake call method ', method, ' with ', gpio_number
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
