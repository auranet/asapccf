module ASAP
  module ADT

    class ValidatableObject
      
      # Class Variables
      
      @@dictionary = {:readers => {}, :accessors => {}, :derivers => {}}
      
      # API/DSL Class Methods
      
      class << self
    
        def define_readers(readers={})
          readers.each_key {|attribute| attr_reader attribute}
          @@dictionary[:readers][self] = readers
          define_inherited_attributes(:readers)
        end
        
        def define_accessors(accessors={})
          accessors.each do |attribute, specification|
            if specification[:converter]
              attr_reader attribute
              attribute_name = attribute.to_s
              variable_name = "@#{attribute_name}"
              module_eval %{def #{attribute_name}=(proposed_value)
                              data_type = attribute_data_type(:accessors, :#{attribute_name})
                              data_converter = attribute_data_converter(:accessors, :#{attribute_name})
                              if !data_type || (!proposed_value.kind_of?(data_type) && proposed_value.class.name != data_type.name)
                                #p 'DATATYPE = ' + data_type.hash.to_s
                                #p 'VALUETYPE = ' + proposed_value.class.hash.to_s
                                #{variable_name} = (data_converter.kind_of?(Proc) ? data_converter.call(proposed_value) : proposed_value.send(data_converter))
                              else
                                #{variable_name} = proposed_value
                              end
                            end }
            else
              attr_accessor attribute
            end
          end
          @@dictionary[:accessors][self] = accessors
          define_inherited_attributes(:accessors)
        end
        
        def define_derivers(derivers={})
          derivers.each {|attribute, specification| define_method attribute, specification[:deriver]}
          @@dictionary[:derivers][self] = derivers
          define_inherited_attributes(:derivers)
        end
      
      end
      
      # Initializer
      
      def initialize(initializers={})
        initializers[:class] ||= self.class
        if @@dictionary[:readers][initializers[:class]]
          initialize_attributes(@@dictionary[:readers][initializers[:class]], initializers) do |attribute|
            self.instance_variable_set('@'.concat(attribute.to_s).to_sym, initializers[attribute])
          end
        end
        if @@dictionary[:accessors][initializers[:class]]
          initialize_attributes(@@dictionary[:accessors][initializers[:class]], initializers, true) do |attribute|
            self.send(attribute.to_s.concat('=').to_sym, initializers[attribute])
          end
        end
        initializers[:class] = initializers[:class].superclass
        self
      end
      
      # Instance Validation API
      
      def valid?
        validate rescue false
      end
      
      def invalid?
        !valid?
      end
      
      def validate
        attribute_errors = []
        attribute_specifications = ((@@dictionary[:readers][self.class] || {}).merge(@@dictionary[:accessors][self.class] || {}))
        attribute_specifications.each do |attribute, specification|
          value = self.instance_variable_get('@'.concat(attribute.to_s).to_sym)
          unless attribute_value_valid?(specification[:type], specification[:required], specification[:validator], value)
            attribute_errors << AttributeValidationError.new(self.class, attribute, %Q|value "#{value}" invalid|)
          end
        end
        if attribute_errors.size > 0
          raise ObjectValidationError.new(attribute_errors)
        end
        true
      end
      
      # Private Implementation Methods
      
      private
      
      class << self
      
        def define_inherited_attributes(attribute_type)
          klass = self.superclass
          until klass == ValidatableObject
            @@dictionary[attribute_type][self].augment! @@dictionary[attribute_type][klass] unless @@dictionary[attribute_type][klass].nil?
            klass = klass.superclass
          end
        end
      
      end
      
      def attribute_data_type(attribute_type, attribute)
        @@dictionary[attribute_type][self.class][attribute][:type]
      end
      
      def attribute_data_converter(attribute_type, attribute)
        @@dictionary[attribute_type][self.class][attribute][:converter]
      end
      
      def attribute_validator(attribute_type, attribute)
        @@dictionary[attribute_type][self.class][attribute][:validator]
      end
      
      def attribute_value_valid?(data_type, data_required, validator, value)
        valid = true
        valid &&= value.kind_of?(data_type) if data_type && !value.nil?
        valid &&= !value.nil?               if data_required
        valid &&= validator.call(value)     if validator
        valid
      end
      
      def initialize_attributes(attributes, initializers, mutable = false)
        attributes.each do |attribute, specification|
          if initializers[attribute].nil?
            if specification[:default].nil?
              self.instance_variable_set('@'.concat(attribute.to_s).to_sym, nil)
            else
              initializers[attribute] = specification[:default].dup rescue specification[:default]
              yield attribute # rely on mutator's built-in conversion
            end
          else
            yield attribute # rely on mutator's built-in conversion
          end
        end
      end
      
      public # jps
      def to_s
        @@dictionary[:accessors][self.class].keys.map {|key| "#{key}: #{self.instance_variable_get('@'.concat(key.to_s).to_sym)}"}.join('; ')
      end

    end
    
  end
end