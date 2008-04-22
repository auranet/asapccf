module ASAP
  module ADT
  
    class Address < ValidatableObject
      define_accessors :street_address     => {},
                       :city               => {},
                       :state_or_province  => {:type => StateOrProvince, :converter => lambda {|value| StateOrProvince::common(value)}},
                       :zip_or_postal_code => {},
                       :country            => {}
      
      def initialize(street_address, city, state_or_province, zip_or_postal_code, country, initializers={})
        super initializers
        @street_address = street_address
        @city = city
        @state_or_province = state_or_province
        @zip_or_postal_code = zip_or_postal_code
        @country = country
      end
    end
    
  end
end
