module ASAP
  module ADT
    module GIS
      
      class CartesianPoint < CartesianObject
        define_accessors :x => {:type      => Float,
                                :required  => true,
                                :converter => :to_f,
                                :validator => lambda {|value| value > 0.0}},
                         :y => {:type      => Float,
                                :required  => true,
                                :converter => :to_f,
                                :validator => lambda {|value| value > 0.0}},
                         :z => {:type      => Float,
                                :converter => :to_f}
        
        def to_s
          text = [x, y].join ", "
          text << ", #{z}" unless z.nil?
          text
        end
       
        def to_geographic(coordinate_system)
          (longitude, latitude) = ASAP::Utility::CoordinateSystemMapper::cartesian_to_geographic(coordinate_system, [x, y])
          GeographicPoint.new(:longitude => longitude, :latitude => latitude)
        end
      end

    end
  end
end