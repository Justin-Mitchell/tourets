module TouRETS
  class Property
    include Utilities
    extend Utilities

    SEARCH_QUERY_DEFAULTS = {}
    SEARCH_CONFIG_DEFAULTS = {:search_type => :Property, :class => 'Listing'}

    class << self

      def where(search_params = {})
        TouRETS.ensure_connected!

        [].tap do |properties|
          search_params = map_search_params(SEARCH_QUERY_DEFAULTS.merge(search_params))
          search_config = SEARCH_CONFIG_DEFAULTS.merge({:query => hash_to_rets_query_string(search_params)})
          Search.find(search_config) do |property|
            binding.pry
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
          pics << TouRETS::Photo.find(attributes['Matrix_Unique_ID'], :resource => :Property)
        end.flatten
      end

  end
end
