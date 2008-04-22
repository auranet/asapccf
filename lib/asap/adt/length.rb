module ASAP
  module ADT

    class Length < DimensionalSize
      define_accessors :unit      => {:type => UnitOfMeasure,
                                      :required => true,
                                      :converter => lambda {|value| UnitOfMeasure::common(value)},
                                      :validator => lambda {|value| value.base_dimensions == 1 && value.exponent == 1}}
    end
    
  end
end
