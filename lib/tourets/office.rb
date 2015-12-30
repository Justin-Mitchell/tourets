module TouRETS
  class Office
    include Utilities
    extend Utilities
    
    SEARCH_QUERY_DEFAULTS = {}
    # This class searches for Offices
    # Some MLS use "11", some use :Off... Will need to decide which way is to be used.
    # Meta-Classes are as listed in the following
    #
    # city => 1608
    # state => 1609
    # address => 1645
    # city_and_state => 1647
    # last_transaction_code => 1650
    # last_transaction_timestamp => 1651
    # office_code => 1652
    # office_name => 1653
    # roster_flag => 1658
    # zip_code => 1659
    # designated_broker => 2217
    # designated_broker_name => 2533
    #
    
    SEARCH_CONFIG_DEFAULTS = {:search_type => :Office, :class => "11"}
    
    class << self
      
      def all
        where
      end
      
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |offices|
          search_params = map_office_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |office|
            offices << self.new(office)
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
