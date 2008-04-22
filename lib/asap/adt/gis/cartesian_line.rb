module ASAP
  module ADT
    module GIS
      
      class CartesianLine < CartesianPointContainer
        define_accessors :endpoints  => {:type      => Array,
                                         :default   => [],
                                         :validator => lambda {|value| value.size == 2 && value.all? {|endpoint| endpoint.kind_of? CartesianPoint}}}
        
        def to_s
          unit.to_s << ": " << endpoints.join("; ")
        end
        
        def contains?(reference_point)
          # Tests the reference point to ensure that it lies on this polyline
          
          # First test to see if it's one of our vertices
          point1, point2 = endpoints
          return true if ((point1.x - reference_point.x).abs <= 16.0 && (point1.y - reference_point.y).abs <= 16.0) ||
                         ((point2.x - reference_point.x).abs <= 16.0 && (point2.y - reference_point.y).abs <= 16.0)
          
          # Now test to see if the point lies on one of our lines.
          # If the slope from the line start to ref point is equal to the slope 
          # from the ref point to the line end then we know the point lies on our line.
          # theta is a plane angle represented in degrees
          theta1 = theta(point1, reference_point)
          theta2 = theta(reference_point, point2)
          return false if theta1 == :identity || theta2 == :identity
          
          theta_diff = theta1 - theta2
          theta_diff.abs < 0.01
        end
        
        def overlaps?(other_line)
          theta1 = theta
          theta2 = theta(other_line.endpoints[0], other_line.endpoints[1])
          #p "theta1: #{theta1}"
          #p "theta2: #{theta2}"
          return false if theta1 == :identity || theta2 == :identity
          theta_diff = theta1 - theta2
          #p "theta_diff.abs: #{theta_diff.abs}"
          #p theta_diff.abs unless theta_diff.abs < 0.01 #DEBUG
          theta_diff.abs < 0.01
        end
                
        def theta(point1 = endpoints[0], point2 = endpoints[1])
          # Find the heading of the line between the points given, or our own heading if no args are passed
          return :identity if point1.x == point2.x && point1.y == point2.y
          return 90.0 if point1.x == point2.x
          # Ahhh Ruby you CAN divide a float by zero and not get an error!!!
          # you get -Infinity which causes the angle returned here to be negitive, so add .abs
          return (Math::atan((point1.x - point2.x)/(point1.y - point2.y)) * 57.29578).abs
        end
        
        alias method_missing_standard_procedure method_missing
        def method_missing(method, *arguments, &block)
          self.endpoints ||= []
          self.endpoints.send method, *arguments, &block
        end
        
        protected
        
        def generate_point(*arguments, &block)
          CartesianPoint.new(*arguments, &block)
        end
        
        def point_between(ref_point, point1, point2)
          
        end
      end

    end
  end
end