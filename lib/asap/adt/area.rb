module ASAP
  module ADT

    class Area < DimensionalSize
      define_accessors :unit => {:type      => UnitOfMeasure,
                                 :required  => true,
                                 :converter => lambda {|value| UnitOfMeasure::common(value)},
                                 :validator => lambda {|value| value.base_dimensions == 2 || value.exponent == 2}}
      
      def initialize(magnitude, unit, initializers={})
        super initializers
        @magnitude = magnitude
        @unit = unit
      end
    end
    
  end
end
