module TouRETS
  class Media
    include Utilities
    extend Utilities
    
    SEARCH_QUERY_DEFAULTS = {}
    # This class searches for Open Houses
    # Some MLS use "15", some use :OpenHouse
    # Meta-Classes are as listed in the following
    #
    # ml_num => MLNumber
    # image_type => ImageType
    # shot_number => ShotNumber
    # comments => Comments
    # resource_name => ResourceName
    # view_picture_id => ViewPictureID
    #
        
    SEARCH_CONFIG_DEFAULTS = {:search_type => :Media, :class => 1026}
    
    class << self
      
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |media|
          search_params = map_media_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |medium|
            media << self.new(medium)
          end
        end
      end
      
      def metadata
        url = "http://glvar.apps.retsiq.com/rets/getmetadata?Type=METADATA-TABLE&ID=Media&Format=STANDARD-XML"
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