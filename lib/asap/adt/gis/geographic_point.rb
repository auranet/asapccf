module ASAP
  module ADT
    module GIS
          
      class GeographicPoint < GeographicObject
        define_accessors :latitude  => {:type      => Latitude,
                                        :required  => true,
                                        :converter => lambda {|value| Latitude.new(:value => value.abs, :hemisphere => (value >= 0 ? :north : :south))}},
                         :longitude => {:type      => Longitude,
                                        :required  => true,
                                        :converter => lambda {|value| Longitude.new(:value => value.abs, :hemisphere => (value >= 0 ? :east : :west))}},
                         :elevation => {:type      => Elevation,
                                        :converter => lambda {|value| Elevation.new(:value => value)}}
        
        def to_s
          text = [longitude, latitude ].join ", "
          text << ", #{elevation}" unless elevation.nil?
          text
        end
       
        def to_cartesian(coordinate_system)
          (x, y) = ASAP::Utility::CoordinateSystemMapper::geographic_to_cartesian(coordinate_system, [longitude.signed_value, latitude.signed_value])
          CartesianPoint.new(:x => x, :y => y)
        end
      end

    end
  end
end