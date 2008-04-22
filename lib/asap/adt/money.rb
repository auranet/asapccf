module ASAP
  module ADT
  
    class Money < ValidatableObject
      define_readers   :currency => {:type      => Currency,
                                     :converter => lambda {|value| Currency.new(:code => value)},
                                     :default   => Currency.new}
      define_accessors :amount   => {:type      => Float,
                                     :converter => :to_f,
                                     :default   => 0.00}
      
      def to_f
        @amount
      end
      
      def to_html
        @amount.zero? ? '' : sprintf('%.2f', @amount)
      end
  
      def to_html_with_currency
        currency.code + ' ' + to_html
      end
    end

  end
end