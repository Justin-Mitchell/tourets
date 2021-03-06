module TouRETS
  class Lotsnland
    include Utilities
    extend Utilities
    
    SEARCH_QUERY_DEFAULTS = {:status => "ER,EA,C,S,P,X,W,WC", :idx => "Y"}
    # This class searches for ResidentialProperty, Condo, SingleFamily, Rental
    # Some MLS use "5", some use :LND... Will need to decide which way is to be used.
    # Meta-Classes are as listed in the following
    # 
    # Description  => Vacant / Subdivided Land
    # StandardName => LotsAndLand
    # VisibleName  => LND
    # ClassName    => 5
    #
    SEARCH_CONFIG_DEFAULTS = {:search_type => :Property, :class => "5"}
    
    class << self
      
      # Returns an array of all of the properties. Same as calling where() with no options
      # TODO: figure out why it limits to 5,000 records.
      # Property.all
      def all
        where
      end
      
      # Returns an array of property results. A Property is defined as ["Single Family Residential", "Manufactured Home", "Condominium", "Townhouse"]
      # Property.where(:bedrooms => 7, :bathrooms => 4, :list_price => 200000..300000)
      # Property.where(:property_type => {:not => ['CONDO', 'TOWNHOME']}, :area => {:or => ['South West', 'North West']})
      # Property.where(:area => ['South West', 'North West']) # This is like 'AND'
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |properties|
          search_params = map_search_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |property|
            properties << self.new(property)
          end
        end
      end
      
    end
    
    attr_accessor :attributes
    
    def initialize(args = {})
      self.attributes = args
    end
    
    # Return an array of the photo objects that belong to a particular property
    def photos
      @photos ||= grab_photos
    end
    
    # Look for one of the mapped keys, and return the value or throw method missing error.
    def method_missing(method_name, *args, &block)
      mapped_key = key_map[method_name.to_sym]
      if attributes.has_key?(mapped_key)
        attributes[mapped_key]
      else
        super
      end
    end
    
    private
    
      def grab_photos
        [].tap do |pics|
          pics << TouRETS::Photo.find(attributes['sysid'], :resource => :Property)
        end.flatten
      end
    
  end
end
