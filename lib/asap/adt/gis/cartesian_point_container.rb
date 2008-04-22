module ASAP
  module ADT
    module GIS
      
      class CartesianPointContainer < CartesianObject
        define_readers   :coordinate_system => {:type      => CoordinateSystem,
                                                :required  => true,
                                                :converter => lambda {|value| CoordinateSystem::common(value)}}
        define_accessors :unit              => {:type      => UnitOfMeasure,
                                                :required  => true,
                                                :converter => lambda {|value| UnitOfMeasure::common(value)},
                                                :validator => lambda {|value| value.base_dimensions == 1 && value.exponent == 1}}
  
        abstract :area
        
        protected
        
        def generate_point(*arguments, &block)
          CartesianPoint.new(*arguments, &block)
        end
        
        def generate_line(*arguments, &block)
          CartesianLine.new(*arguments, &block)
        end
      end

    end
  end
end