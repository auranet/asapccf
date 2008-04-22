require 'csmap'

module ASAP
  module ADT
    module GIS
        
      class CoordinateSystem < ValidatableObject
        define_accessors :category      => {:type => Symbol,          :default  => :local},
                         :minimum_point => {:type => GeographicPoint, :required => true},
                         :maximum_point => {:type => GeographicPoint, :required => true},
                         :datum         => {:type => Symbol,          :default  => :grs1980},
                         :unit          => {:type => Symbol,          :required => true},
                         :scale         => {:type => Float,           :default  => 1.0}
        
        def allocate_resources
          raise unless @datum_pointer = Csmap::CS_dtloc(datum.to_s.upcase)
          raise unless @cs_pointer    = Csmap::local_coordinate_system(minimum_point.longitude.signed_value,
                                                                       minimum_point.latitude.signed_value,
                                                                       maximum_point.longitude.signed_value,
                                                                       maximum_point.latitude.signed_value,
                                                                       unit.to_s.upcase, @datum_pointer, scale)
        end
        
        def cs_pointer
          @cs_pointer
        end
        
        def release_resources
          Csmap::CS_free(@cs_pointer)    if @cs_pointer
          Csmap::CS_free(@datum_pointer) if @datum_pointer
        end
      end

    end
  end
end