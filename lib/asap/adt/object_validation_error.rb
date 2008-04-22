module ASAP
  module ADT
  
    class ObjectValidationError < RuntimeError
    
      attr_accessor :attribute_errors
      
      def initialize(proposed_attribute_errors = [])
        attribute_errors = proposed_attribute_errors
        super formatted_message(proposed_attribute_errors)
      end
      
      def formatted_message(attribute_errors)
        attribute_errors.join('; ')
      end
      
    end
    
  end
end
