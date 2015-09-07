require 'rubyserial'

require 'irtoy/misc'
require 'irtoy/receive'
require 'irtoy/transmit'
require 'irtoy/version'

class IRToy < Serial
  attr_reader :port, :baud, :handshake, :protocol_version, :transmit_mode, :sampeling_mode
  attr_accessor :sleep_time, :max_write_size

  include IRToy::Misc
  include IRToy::Receive
  include IRToy::Transmit
  include IRToy::Version

  def initialize(param = {})
    param[:port] = port_autodetect unless param[:port]

    param = {
      baud:           115_200,
      max_write_size: 32,
      sleep_time:     0.1
    }.merge(param)

    @port           = param[:port]
    @baud           = param[:baud]
    @max_write_size = param[:max_write_size]
    @sleep_time     = param[:sleep_time]

    super @port, Integer(@baud)

    check_version unless param[:skip_versioncheck]

    activate_sampling_mode
  end
end
