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
        
        def initialize_copy(other)
          latitude  = other.latitude.clone
          longitude = other.longitude.clone
          elevation = other.elevation.clone if !elevation.nil?
        end
        
        def signed_latitude=(lat)
          @latitude.value = lat.abs
        end
        
        def signed_longitude=(lng)
          @longitude.value = lng.abs
        end        
                
#        def set_longitude(value)
#          @longitude.value = value.abs
#        end
#        
#        def set_latitude(value)
#          @latitude.value = value.abs
#        end
        
        def signed_latitude          
          @latitude.signed_value
        end
        
        def signed_longitude
          @longitude.signed_value
        end
        
        def eql?(other)
            self.signed_latitude == other.signed_latitude and self.signed_longitude == other.signed_longitude
        end
        
        def within_radius?(other, tolerance = POINT_RADIUS)
            dy = self.signed_latitude  - other.signed_latitude
            dx = self.signed_longitude - other.signed_longitude
            dx.abs <= tolerance and dy.abs <= tolerance
        end
        
        def within_longitude_tolerance?(other, tolerance = POINT_RADIUS)
            dx = self.signed_longitude - other.signed_longitude
            dx.abs <= tolerance
        end
        
        def within_latitude_tolerance?(other, tolerance = POINT_RADIUS)
            dy = self.signed_latitude  - other.signed_latitude
            dy.abs <= tolerance
        end
                 
        def move_point(longitude=0, latitude=0)
          @longitude.value += longitude
          @latitude.value  += latitude
        end
        
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