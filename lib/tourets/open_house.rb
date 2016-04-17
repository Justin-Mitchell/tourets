module TouRETS
  class User
    include Utilities
    extend Utilities
    
    SEARCH_QUERY_DEFAULTS = {}
    # This class searches for Open Houses
    # Some MLS use "15", some use :OpenHouse
    # Meta-Classes are as listed in the following
    #
    # ml_num => 2163
    # list_office_code => 2166
    # property_type => 2167
    # list_price => 2168
    # street_number => 2169
    # compass_point => 2170
    # street_name => 2172
    # area => 2172
    # address => 2173
    # list_agent_public_id => 2174
    # bedrooms => 2175
    # zip_code => 2176
    # open_house_date => 2177
    # open_house_time => 2178
    # open_house_type => 2179
    # open_house_status => 2180
    # refreshments => 2181
    # open_house_remarks => 2181
    # open_house_directions => 2183
    # parcel_num => 2186
    # property_status => 2187
    #
    
    
    SEARCH_CONFIG_DEFAULTS = {:search_type => :OpenHouse, :class => 15}
    
    class << self
      
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |open_houses|
          search_params = map_open_houses_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |open_house|
            open_houses << self.new(open_house)
          end
        end
      end
      
    end
    
    attr_accessor :attributes
    
    def initialize(args = {})
      self.attributes = args
    end
    
    # Look for one of the mapped keys, and return the value or throw method missing error.
    def method_missing(method_name, *args, &block)
      mapped_key = office_map[method_name.to_sym]
      if attributes.has_key?(mapped_key)
        attributes[mapped_key]
      else
        super
      end
    end
    
  end
end