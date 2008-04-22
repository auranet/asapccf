require 'date'

module ASAP
  module Utility

    class DateFormatter
      
      def self.in_words(date)
        self.in_words_without_year(date) + ', ' + date.year.to_s
      end
      
      def self.in_words_without_year(date)
        Date::MONTHNAMES[date.month] + ' ' + date.mday.to_s
      end
      
      def self.standard(date)
        date.month.to_s + '/' + date.mday.to_s + '/' + date.year.to_s
      end
      
    end

  end
end
