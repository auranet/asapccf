module ASAP
  module ADT
    module GIS
        
      class GeographicCoordinate < ValidatableObject
        define_accessors :value      => {:type      => Float,
                                         :required  => true,
                                         :converter => :to_f,
                                         :validator => lambda {|value| value >= 0.0}}
        
        def to_s
          format(FLOAT_FORMAT, value)
        end
        
        def as_precision
          format(FLOAT_FORMAT, value).to_f
        end
        
      end

    end
  end
end