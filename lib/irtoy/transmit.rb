class IRToy < Serial
  module Transmit
    def transmit(code)
      fail 'Length of code argument must be greater than or equal to two' if code.size < 2
      fail 'Length of code argument must be an even number'               if code.size.odd?

      last_codes = [255, 255]
      code += last_codes if code[-2..-1] != last_codes

      begin
        rest
        activate_transmit_mode
        write_list code, true
        rest
        transmit_report

        unless %w(c C).include? @complete
          fail "Failed to transmit IR code, report=#{@complete}"
        end
      rescue
        reset
        activate_sampling_mode
        raise
      end

      # experimentation shows that returning
      # to sampling mode is needed to avoid
      # dropping the serial connection on Linux
      activate_sampling_mode
    end

    def activate_transmit_mode
      return if @transmit_mode

      rest
      write_list [0x26]       # enable transmit handshake
      write_list [0x25]       # enable transmit notify on complete
      write_list [0x24]       # enable transmit byte count report
      write_list [0x03], true # expect to receive packets to transmit

      @transmit_mode  = true
      @sampeling_mode = false
    end

    def write_list(code, check_handshake = false)
      rest

      byte_code     = code.pack('C*')
      bytes_written = 0

      # 31 * 2 bytes = max of 62 bytes in the buffer
      (-1..byte_code.size).step(@max_write_size) do |idx|
        segment = byte_code[idx + 1..idx + @max_write_size]

        segment_written = write segment
        bytes_written += segment_written

        # we need a tiny bit of sleep here, otherwise a nasty
        # exception like follows gets thrown. After that the
        # IRToy has to get to boot mode and a reflash is required :o
        # rubyserial/posix.rb:52:in `write': ENXIO (RubySerial::Exception)
        sleep 0.0001

        next unless check_handshake

        result = ''
        result = read 1 while result.empty?
        @handshake = result.ord

        # we need a tiny bit of sleep here, otherwise a nasty
        # exception like follows gets thrown. After that the
        # IRToy has to get set to boot mode and a reflash is required :o
        # rubyserial/posix.rb:52:in `write': ENXIO (RubySerial::Exception)
        sleep 0.0001
      end

      return if bytes_written == code.size

      fail "Incorrect number of bytes '#{bytes_written}' written to serial device, expected '#{code.size}'"
    end

    def transmit_report
      report      = read 2
      hex_bytes   = report[1..-1]
      @byte_count = hex_bytes.unpack('C*').last

      @complete = ''
      @complete = read 3 while @complete.empty?
    end
  end
end
