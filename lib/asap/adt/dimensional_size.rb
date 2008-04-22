module ASAP
  module ADT

    class DimensionalSize < ValidatableObject
      define_accessors :magnitude => {:type      => Float,
                                      :required  => true,
                                      :converter => :to_f,
                                      :validator => lambda {|value| value >= 0.0}},
                       :unit      => {:type      => UnitOfMeasure,
                                      :required  => true,
                                      :converter => lambda {|value| UnitOfMeasure::common(value)}}
      
      def to_f
        magnitude
      end
      
      def to_s
        magnitude.to_s << " " << unit.to_s
      end
    end
    
  end
end
