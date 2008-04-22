module ASAP
  module ADT
    module GIS
      
      class CartesianRectangle < CartesianPointContainer
        define_accessors :corners => {:type      => Array,
                                      :required  => true,
                                      :validator => lambda {|value| value.size == 2 && value.all? {|corner| corner.kind_of? CartesianPoint}}}
        
        def to_s
          unit.to_s << ": " << corners.join("; ")
        end
        
        def area
          Area.new(((corners[1].y - corners[0].y) * (corners[1].x - corners[0].x)).abs,
                   UnitOfMeasure::common(unit.abbreviation, unit.exponent + 1))
        end
      end

    end
  end
end