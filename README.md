# IRToy

A ruby gem for transmitting and receiving infrared signals from an IR Toy.
This requires the Dangerous Prototype USB IR Toy (http://dangerousprototypes.com/docs/USB_Infrared_Toy) with firmware revision 22 or higher.

This gem has been tested with Ruby 2.1.5 and 2.2.1 on Mac OS X Yosemite. There is no OS specific code in this gem, so it should work on Mac OS, Linux and Windows but has not been tested.

This gem is available on RubyGems (https://rubygems.org/gems/irtoy) and can be installed with bundler or the following command:
```
gem install irtoy
```

This gem makes it easy to transmit to and receive from an IR Toy.

# Usage

## Object creation

```ruby
require 'irtoy'

irtoy = IRToy.new(
  skip_versioncheck: true,    # optional, default false
  baud:              115200,  # optional
  max_write_size:    32,      # optional, shouldn't be more
  sleep_time:        0.1,     # optional, shouldn't be less
)
```

## Version stuff
```ruby
> irtoy.version
=> "V222"
```

```ruby
> irtoy.firmware_version
=> 22
```

```ruby
> irtoy.hardware_version
=> "V2"
```

## Receiving

```ruby
> ir_code = irtoy.receive
# *button press on fan remote*
=> [0, 58, 0, 20, 0, 58, 0, 20, 0, 19, 0, 58, 0, 59, 0, 20, 0, 58, 0, 20, 0, 19, 0, 58, 0, 20, 0, 59, 0, 19, 0, 58, 0, 19, 0, 59, 0, 19, 0, 59, 0, 59, 0, 20, 0, 18, 1, 119, 0, 58, 0, 21, 0, 57, 0, 21, 0, 18, 0, 59, 0, 58, 0, 21, 0, 57, 0, 21, 0, 17, 0, 60, 0, 19, 0, 59, 0, 19, 0, 58, 0, 20, 0, 59, 0, 19, 0, 58, 0, 57, 0, 22, 0, 19, 1, 118, 0, 57, 0, 22, 0, 56, 0, 22, 0, 19, 0, 58, 0, 57, 0, 22, 0, 56, 0, 22, 0, 19, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 57, 0, 22, 0, 18, 1, 120, 0, 56, 0, 22, 0, 56, 0, 22, 0, 17, 0, 60, 0, 56, 0, 22, 0, 56, 0, 22, 0, 17, 0, 60, 0, 20, 0, 58, 0, 19, 0, 58, 0, 19, 0, 59, 0, 18, 0, 60, 0, 56, 0, 22, 0, 17, 255, 255]
```

## Transmitting

```ruby
ir_code = 0, 58, 0, 20, 0, 58, 0, 20, 0, 19, 0, 58, 0, 59, 0, 20, 0, 58, 0, 20, 0, 19, 0, 58, 0, 20, 0, 59, 0, 19, 0, 58, 0, 19, 0, 59, 0, 19, 0, 59, 0, 59, 0, 20, 0, 18, 1, 119, 0, 58, 0, 21, 0, 57, 0, 21, 0, 18, 0, 59, 0, 58, 0, 21, 0, 57, 0, 21, 0, 17, 0, 60, 0, 19, 0, 59, 0, 19, 0, 58, 0, 20, 0, 59, 0, 19, 0, 58, 0, 57, 0, 22, 0, 19, 1, 118, 0, 57, 0, 22, 0, 56, 0, 22, 0, 19, 0, 58, 0, 57, 0, 22, 0, 56, 0, 22, 0, 19, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 20, 0, 58, 0, 57, 0, 22, 0, 18, 1, 120, 0, 56, 0, 22, 0, 56, 0, 22, 0, 17, 0, 60, 0, 56, 0, 22, 0, 56, 0, 22, 0, 17, 0, 60, 0, 20, 0, 58, 0, 19, 0, 58, 0, 19, 0, 59, 0, 18, 0, 60, 0, 56, 0, 22, 0, 17, 255, 255]

irtoy.transmit ir_code

# *fan starts*
```

# Acknowledgement

This gem is heavily inspiered by https://github.com/crleblanc/PyIrToy and https://github.com/djellemah/irtoy-hexbug-spider . Huge thanks to @crleblanc and @djellemah for the inspiration.

# License

The code is released under the GPL 3. See the LICENSE file for further information.
