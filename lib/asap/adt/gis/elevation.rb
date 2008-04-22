module ASAP
  module ADT
    module GIS
    
      class Elevation < GeographicCoordinate
        define_accessors :unit => {:type      => UnitOfMeasure,
                                   :required  => true,
                                   :converter => lambda {|value| UnitOfMeasure::common(value)},
                                   :validator => lambda {|value| value.base_dimensions == 1 && value.exponent == 1}}
        
        def to_s
          super << unit.to_s
        end
      end

    end
  end
end