require 'date'

module ASAP
  module Utility
    
    class TimeFormatter
      
      def self.standard(time)
        hour_for_ampm(time.hour).to_s + ':' + pad_2_digits(time.min) + ' ' + ampm(time.hour)
      end
      
      private
      
      def self.hour_for_ampm(hour)
        if hour == 0
          12
        elsif hour > 12
          hour - 12
        else
          hour
        end
      end
      
      def self.ampm(hour)
        hour < 12 ? 'AM' : 'PM'
      end
      
      def self.pad_2_digits(number)
        number < 10 ? '0' + number.to_s : number.to_s
      end
    
    end

  end
end
