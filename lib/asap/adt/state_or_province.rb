module ASAP
  module ADT
    
    class StateOrProvince < ValidatableObject
      define_readers   :abbreviation => {:type      => String,
                                         :required  => true,
                                         :validator => lambda {|value| value.length <= 3}},
                       :name         => {:required  => true}
      
      def to_s
        abbreviation
      end
      
      @@common_instances = {:al => StateOrProvince.new(:abbreviation => 'AL', :name => 'Alabama'),
                            :ak => StateOrProvince.new(:abbreviation => 'AK', :name => 'Alaska'),
                            :as => StateOrProvince.new(:abbreviation => 'AS', :name => 'American Samoa'),
                            :az => StateOrProvince.new(:abbreviation => 'AZ', :name => 'Arizona'),
                            :ar => StateOrProvince.new(:abbreviation => 'AR', :name => 'Arkansas'),
                            :ca => StateOrProvince.new(:abbreviation => 'CA', :name => 'California'),
                            :co => StateOrProvince.new(:abbreviation => 'CO', :name => 'Colorado'),
                            :ct => StateOrProvince.new(:abbreviation => 'CT', :name => 'Connecticut'),
                            :de => StateOrProvince.new(:abbreviation => 'DE', :name => 'Delaware'),
                            :dc => StateOrProvince.new(:abbreviation => 'DC', :name => 'District of Columbia'),
                            :fm => StateOrProvince.new(:abbreviation => 'FM', :name => 'Federated States of Micronesia'),
                            :fl => StateOrProvince.new(:abbreviation => 'FL', :name => 'Florida'),
                            :ga => StateOrProvince.new(:abbreviation => 'GA', :name => 'Georgia'),
                            :gu => StateOrProvince.new(:abbreviation => 'GU', :name => 'Guam'),
                            :hi => StateOrProvince.new(:abbreviation => 'HI', :name => 'Hawaii'),
                            :id => StateOrProvince.new(:abbreviation => 'ID', :name => 'Idaho'),
                            :il => StateOrProvince.new(:abbreviation => 'IL', :name => 'Illinois'),
                            :in => StateOrProvince.new(:abbreviation => 'IN', :name => 'Indiana'),
                            :ia => StateOrProvince.new(:abbreviation => 'IA', :name => 'Iowa'),
                            :ks => StateOrProvince.new(:abbreviation => 'KS', :name => 'Kansas'),
                            :ky => StateOrProvince.new(:abbreviation => 'KY', :name => 'Kentucky'),
                            :la => StateOrProvince.new(:abbreviation => 'LA', :name => 'Louisiana'),
                            :me => StateOrProvince.new(:abbreviation => 'ME', :name => 'Maine'),
                            :mh => StateOrProvince.new(:abbreviation => 'MH', :name => 'Marshall Islands'),
                            :md => StateOrProvince.new(:abbreviation => 'MD', :name => 'Maryland'),
                            :ma => StateOrProvince.new(:abbreviation => 'MA', :name => 'Massachusetts'),
                            :mi => StateOrProvince.new(:abbreviation => 'MI', :name => 'Michigan'),
                            :mn => StateOrProvince.new(:abbreviation => 'MN', :name => 'Minnesota'),
                            :ms => StateOrProvince.new(:abbreviation => 'MS', :name => 'Mississippi'),
                            :mo => StateOrProvince.new(:abbreviation => 'MO', :name => 'Missouri'),
                            :mt => StateOrProvince.new(:abbreviation => 'MT', :name => 'Montana'),
                            :ne => StateOrProvince.new(:abbreviation => 'NE', :name => 'Nebraska'),
                            :nv => StateOrProvince.new(:abbreviation => 'NV', :name => 'Nevada'),
                            :nh => StateOrProvince.new(:abbreviation => 'NH', :name => 'New Hampshire'),
                            :nj => StateOrProvince.new(:abbreviation => 'NJ', :name => 'New Jersey'),
                            :nm => StateOrProvince.new(:abbreviation => 'NM', :name => 'New Mexico'),
                            :ny => StateOrProvince.new(:abbreviation => 'NY', :name => 'New York'),
                            :nc => StateOrProvince.new(:abbreviation => 'NC', :name => 'North Carolina'),
                            :nd => StateOrProvince.new(:abbreviation => 'ND', :name => 'North Dakota'),
                            :mp => StateOrProvince.new(:abbreviation => 'MP', :name => 'Northern Mariana Islands'),
                            :oh => StateOrProvince.new(:abbreviation => 'OH', :name => 'Ohio'),
                            :ok => StateOrProvince.new(:abbreviation => 'OK', :name => 'Oklahoma'),
                            :or => StateOrProvince.new(:abbreviation => 'OR', :name => 'Oregon'),
                            :pa => StateOrProvince.new(:abbreviation => 'PA', :name => 'Pennsylvania'),
                            :pr => StateOrProvince.new(:abbreviation => 'PR', :name => 'Puerto Rico'),
                            :ri => StateOrProvince.new(:abbreviation => 'RI', :name => 'Rhode Island'),
                            :sc => StateOrProvince.new(:abbreviation => 'SC', :name => 'South Carolina'),
                            :sd => StateOrProvince.new(:abbreviation => 'SD', :name => 'South Dakota'),
                            :tn => StateOrProvince.new(:abbreviation => 'TN', :name => 'Tennessee'),
                            :tx => StateOrProvince.new(:abbreviation => 'TX', :name => 'Texas'),
                            :ut => StateOrProvince.new(:abbreviation => 'UT', :name => 'Utah'),
                            :vt => StateOrProvince.new(:abbreviation => 'VT', :name => 'Vermont'),
                            :va => StateOrProvince.new(:abbreviation => 'VA', :name => 'Virginia'),
                            :vi => StateOrProvince.new(:abbreviation => 'VI', :name => 'Virgin Islands, U.S.'),
                            :wa => StateOrProvince.new(:abbreviation => 'WA', :name => 'Washington'),
                            :wv => StateOrProvince.new(:abbreviation => 'WV', :name => 'West Virginia'),
                            :wi => StateOrProvince.new(:abbreviation => 'WI', :name => 'Wisconsin'),
                            :wy => StateOrProvince.new(:abbreviation => 'WY', :name => 'Wyoming'),
                            :aa => StateOrProvince.new(:abbreviation => 'AA', :name => 'Armed Forces the Americas'),
                            :ae => StateOrProvince.new(:abbreviation => 'AE', :name => 'Armed Forces Europe'),
                            :ap => StateOrProvince.new(:abbreviation => 'AP', :name => 'Armed Forces Pacific'),
                            :ab => StateOrProvince.new(:abbreviation => 'AB', :name => 'Alberta'),
                            :bc => StateOrProvince.new(:abbreviation => 'BC', :name => 'British Columbia'),
                            :mb => StateOrProvince.new(:abbreviation => 'MB', :name => 'Manitoba'),
                            :nb => StateOrProvince.new(:abbreviation => 'NB', :name => 'New Brunswick'),
                            :nl => StateOrProvince.new(:abbreviation => 'NL', :name => 'Newfoundland'),
                            :nt => StateOrProvince.new(:abbreviation => 'NT', :name => 'Northwest Territories'),
                            :ns => StateOrProvince.new(:abbreviation => 'NS', :name => 'Nova Scotia'),
                            :nu => StateOrProvince.new(:abbreviation => 'NU', :name => 'Nunavut'),
                            :on => StateOrProvince.new(:abbreviation => 'ON', :name => 'Ontario'),
                            :pe => StateOrProvince.new(:abbreviation => 'PE', :name => 'Prince Edward Island'),
                            :qc => StateOrProvince.new(:abbreviation => 'QC', :name => 'Quebec'),
                            :sk => StateOrProvince.new(:abbreviation => 'SK', :name => 'Saskatchewan'),
                            :yt => StateOrProvince.new(:abbreviation => 'YT', :name => 'Yukon Territory')}
      
      def self.common(key = nil)
        if key.nil?
          @@common_instances.sort {|a, b| a[1].name <=> b[1].name}
        else
          if @@common_instances.include?(key)
            @@common_instances[key]
          else
            unit = nil
            unit_pair = @@common_instances.find {|candidate| candidate.last.abbreviation == key}
            unit = unit_pair.last unless unit_pair.nil?
            unit
          end
        end
      end
    end

  end
end