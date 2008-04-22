module ASAP
  module ADT

    class UnitOfMeasure < ValidatableObject
      define_readers   :abbreviation    => {:type => String,  :required => true},
                       :name            => {                  :required => true},
                       :plural_name     => {                  :required => true},
                       :collective_name => {:required => true},
                       :base_dimensions => {:type => Integer, :required => true, :validator => lambda {|value| value >= 0}},
                       :exponent        => {:type => Integer, :required => true, :validator => lambda {|value| value >= 0}},
                       :conversions     => {:type => Hash,    :default  => {},   :validator => lambda {|value| value.all? {|element| !element.nil? && element.kind_of?(Proc)}}}
      
      def to_s
        abbreviation + (exponent > 1 ? "^#{exponent}" : "")
      end
      
      @@common_instances = {:foot         => UnitOfMeasure.new(:abbreviation    => 'ft',
                                                               :name            => 'foot',
                                                               :plural_name     => 'feet',
                                                               :collective_name => 'footage',
                                                               :base_dimensions => 1, 
                                                               :exponent        => 1),
                            :square_foot  => UnitOfMeasure.new(:abbreviation    => 'ft',
                                                               :name            => 'square foot',
                                                               :plural_name     => 'square feet',
                                                               :collective_name => 'square footage',
                                                               :base_dimensions => 1,
                                                               :exponent        => 2),
                            :meter        => UnitOfMeasure.new(:abbreviation    => 'm',
                                                               :name            => 'meter',
                                                               :plural_name     => 'meters',
                                                               :collective_name => 'meterage',
                                                               :base_dimensions => 1,
                                                               :exponent        => 1),
                            :square_meter => UnitOfMeasure.new(:abbreviation    => 'm',
                                                               :name            => 'square meter',
                                                               :plural_name     => 'square meters',
                                                               :collective_name => 'square meterage',
                                                               :base_dimensions => 1,
                                                               :exponent        => 2),
                            :mile         => UnitOfMeasure.new(:abbreviation    => 'mi',
                                                               :name            => 'mile',
                                                               :plural_name     => 'miles',
                                                               :collective_name => 'mileage',
                                                               :base_dimensions => 1,
                                                               :exponent        => 1),
                            :square_mile  => UnitOfMeasure.new(:abbreviation    => 'mi',
                                                               :name            => 'square mile',
                                                               :plural_name     => 'square miles',
                                                               :collective_name => 'square mileage',
                                                               :base_dimensions => 1,
                                                               :exponent        => 2),
                            :acre         => UnitOfMeasure.new(:abbreviation    => 'acre',
                                                               :name            => 'acre',
                                                               :plural_name     => 'acres',
                                                               :collective_name => 'acreage',
                                                               :base_dimensions => 2,
                                                               :exponent        => 1),
                            :hectare      => UnitOfMeasure.new(:abbreviation    => 'ha',
                                                               :name            => 'hectare',
                                                               :plural_name     => 'hectares',
                                                               :collective_name => 'hectareage',
                                                               :base_dimensions => 2,
                                                               :exponent        => 1)}
      
      def self.common(key, exponent = 1)
        if key.nil?
          @@common_instances.sort {|a, b| a[1].name <=> b[1].name}
        else
          if @@common_instances.include?(key)
            @@common_instances[key]
          else
            unit = nil
            unit_pair = @@common_instances.find {|candidate| candidate.last.abbreviation == key && candidate.last.exponent == exponent}
            unit = unit_pair.last unless unit_pair.nil?
            unit
          end
        end
      end
    end
    
  end
end
