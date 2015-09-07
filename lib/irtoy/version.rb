require 'rubyserial'

class IRToy < Serial
  VERSION = '0.1.1' unless const_defined?('VERSION')

  module Version
    MINVERSION = 22

    def version
      reset
      rest
      write 'v'
      rest
      read 4
    end

    def firmware_version
      version_string = version
      version_string[2..3].to_i
    end

    def hardware_version
      version_string = version
      version_string[0..1]
    end

    def check_version
      version_number = firmware_version
      return if version_number >= MINVERSION
      fail "Firmware version '#{version_number}' found. At least #{MINVERSION} is reqired!"
    end
  end
end
