require 'csmap'

module ASAP
  module Utility
  
    class CoordinateSystemMapper
      
      class << self
        
        def batch_convert(latlong_array)
          Csmap::convert_coordinates("LL27", "LL83", latlong_array)          
        end
        
        
        def nad27_to_nad83(geographic_coordinates)
          converted = Csmap::datum_conversion("LL27", "LL83", geographic_coordinates[1], geographic_coordinates[0])
          x, y  = Csmap::get_ws3_conversion_coordinate(converted, 1), Csmap::get_ws3_conversion_coordinate(converted, 0)
          Csmap::release_ws3_conversion_coordinates(converted)
          [x, y]
        end
        
        def geographic_to_cartesian(coordinate_system, geographic_coordinates)
          converted = nad27_to_nad83(geographic_coordinates)
          cartesian_coordinates = Csmap::ll_to_cs(coordinate_system.cs_pointer, converted[0], converted[1])
          #cartesian_coordinates = Csmap::ll_to_cs(coordinate_system.cs_pointer, geographic_coordinates[0], geographic_coordinates[1])
          x, y = Csmap::get_ws3_conversion_coordinate(cartesian_coordinates, 0), Csmap::get_ws3_conversion_coordinate(cartesian_coordinates, 1)
          Csmap::release_ws3_conversion_coordinates(cartesian_coordinates)
          [x, y]
        end
        
        def cartesian_to_geographic(coordinate_system, cartesian_coordinates)
          geographic_coordinates = Csmap::cs_to_ll(coordinate_system.cs_pointer, cartesian_coordinates[0], cartesian_coordinates[1])
          longitude_value, latitude_value = Csmap::get_ws3_conversion_coordinate(geographic_coordinates, 0), Csmap::get_ws3_conversion_coordinate(geographic_coordinates, 1)
          Csmap::release_ws3_conversion_coordinates(geographic_coordinates)
          [ASAP::ADT::GIS::Longitude.new(:hemisphere => (longitude_value > 0 ? :east : :west), :value => longitude_value.abs),
           ASAP::ADT::GIS::Latitude.new(:hemisphere => (latitude_value > 0 ? :north : :south), :value => latitude_value.abs)]
        end
        
      end
      
    end
    
  end
end
