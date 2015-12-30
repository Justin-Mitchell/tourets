module TouRETS
  class User
    include Utilities
    extend Utilities
    
    SEARCH_QUERY_DEFAULTS = {}
    # This class searches for Realtors in the GLVAR
    # Some MLS use '10', some user :User... 
    # Will need to decide which way is to be used.
    # Meta-Classes are as listed in the following
    #
    # address => 1661
    # office_phone => 1661
    # access_flag => 1664
    # city => 1669
    # state => 1670
    # first_name => 1715
    # fax => 1716
    # last_name => 1717
    # last_transaction_code => 1718
    # last_transaction_timestamp => 1719
    # office_code => 1720
    # roster_flag => 1724
    # agent_id => 1727
    # zip_code => 1730
    # license_number => 2271
    # agent_fullname => 2551
    
    SEARCH_CONFIG_DEFAULTS = {:search_type => :User, :class => '10'}
    
    class << self
      
      def all
        where
      end
      
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |users|
          search_params = map_user_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |user|
            users << self.new(user)
          end
        end
      end
      
      attr_accessor :attributes
      
      def initialize(args = {})
        self.attributes = args
      end
      
      def method_missing(method_name, *args, &block)
        mapped_key = user_map[method_name.to_sym]
        if attributes.has_key?(mapped_key)
          attributes[mapped_key]
        else
          super
        end
      end
      
    end
    
  end
end