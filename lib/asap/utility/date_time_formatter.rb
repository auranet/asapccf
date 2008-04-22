require 'date'

module ASAP
  module Utility

    class DateTimeFormatter
      
      def self.in_words(date_time)
        self.in_words_without_year(date_time) + ', ' + date_time.year.to_s
      end
      
      def self.in_words_without_year(date_time)
        TimeFormatter.standard(date_time) + ' on ' + DateFormatter.in_words_without_year(date_time)
      end
      
      def self.standard(date_time)
        DateFormatter.standard(date_time) + ' ' + TimeFormatter.standard(date_time)
      end
    
    end

  end
end
