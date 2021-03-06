module TouRETS
  class User
    include Utilities
    extend Utilities
    
    # This class searches for Realtors in the GLVAR
    # Some MLS use '10', some user :User... 
    # Will need to decide which way is to be used.
    # Meta-Classes are as listed in the following
    #
    # sysid => sysid
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
    # agentcode => 1727
    # zipcode => 1730
    # license_number => 2271
    # agent_fullname => 2551
    
    SEARCH_QUERY_DEFAULTS = {}
    SEARCH_CONFIG_DEFAULTS = {:search_type => :User, :class => "10"}
    
    class << self
      
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
    
    end
      
    attr_accessor :attributes
    
    def initialize(args = {})
      self.attributes = args
    end
    
    # Return an array of the photo objects that belong to a particular property
    def photo
      @photo ||= grab_photo
    end
    
    # Look for one of the mapped keys, and return the value or throw method missing error.
    def method_missing(method_name, *args, &block)
      mapped_key = user_map[method_name.to_sym]
      if attributes.has_key?(mapped_key)
        attributes[mapped_key]
      else
        super
      end
    end
    
    private
    
      def grab_photo
        [].tap do |pics|
          pics << TouRETS::Photo.find(attributes['sysid'], :resource => :User)
        end.flatten
      end
      
  end 
end
