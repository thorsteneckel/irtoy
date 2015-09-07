class IRToy < Serial
  module Receive
    # # TODO: Required? START
    # TICK_LENGTH = Rational(64,3)

    # # microsecond to sample duration
    # def self.µs_to_sample( ary )
    #   ary.map{|m,s| [(m / IrToy::TICK_LENGTH), ((s / IrToy::TICK_LENGTH) rescue nil)].compact}
    # end
    # # TODO: Required? END

    def receive
      rest
      reset
      activate_sampling_mode

      read_counter = 0
      ir_code      = []
      last_codes   = [255, 255]

      loop do
        read_value = read 1
        int_value  = read_value.unpack('C*').first

        ir_code.push int_value if int_value

        break if read_counter >= 2 && ir_code[-2..-1] == last_codes

        read_counter += 1
      end
      rest
      ir_code
    end

    def activate_sampling_mode
      return if @sampeling_mode
      reset
      write 'S'
      rest
      @protocol_version = read 3
      rest
      @sampeling_mode = true
      @transmit_mode  = false
    end
  end
end
