module TouRETS
  class Property
    include Utilities
    extend Utilities

    SEARCH_QUERY_DEFAULTS = {}
    SEARCH_CONFIG_DEFAULTS = {}

    class << self

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
  end
end
