class IRToy < Serial
  module Misc
    def rest
      sleep @sleep_time
    end

    # send 0xff x 2 (in ascii-8bit) to exit transmit mode
    # send at least one 0x00 to reset the mode
    # send 5 x 0x00 to get it out of SUMP mode
    def reset
      rest
      write_list [0x00] * 5
      @transmit_mode  = false
      @sampeling_mode = false
    end

    def port_autodetect
      case uname = `uname`
      when /Darwin/

        # The technical difference is that /dev/tty.* devices will wait (or listen)
        # for DCD (data-carrier-detect), eg, someone calling in, before responding.
        # /dev/cu.* devices do not assert DCD, so they will always connect (respond
        # or succeed) immediately.

        # So we need to use the cu device here.

        # '/dev/tty.usbmodem00000001'
        '/dev/cu.usbmodem00000001'
      when /Linux/
        '/dev/ttyACM0'
      else
        fail "unknown uname value '#{uname}'"
      end
    end
  end
end
