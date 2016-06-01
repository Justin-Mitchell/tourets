module TouRETS
  module Utilities

    # Convert a key value pair into a RETS formatted query string.
    # TODO: Take values that are arrays, ranges, or hashes, and convert those properly
    def hash_to_rets_query_string(hash)
      [].tap do |str|
        hash.each_pair do |k,v|
          val = value_map(v)
          str << "(#{k.to_s.camelize}=#{val})"
        end
      end.join(',')
    end

    # This takes a hash of search parameters, and modifies
    # the hash to have the correct key types for the current RETS server
    def map_search_params(search_params)
      Hash[search_params.map {|k, v| [key_map[k], v] }]
    end

    def map_office_params(search_params)
      Hash[search_params.map {|k,v| [office_map[k], v] }]
    end

    def map_user_params(search_params)
      Hash[search_params.map {|k, v| [user_map[k], v] }]
    end

    # Giant Hash.
    # TODO: OPTIMIZE!!!! ZOMG! O_o
    # Maybe break this into a YAML file that will pick which keymap to use based on the current_connection?
    # I'm thinking maybe like a dictionary lookup. Figure out what each RETS server uses.
    # Also good to note that there are different data types, but they all are strings.
    # We could figure out a way to convert to Integer, or DateTime objects, etc... depending.
    # All results are esentially just strings. The comments below indicate what the value type should be by how it's formatted
    def key_map
      {
        mls_number: 'MLSNumber',
        matrix_modified_timestamp: 'MatrixModifiedDT',
        provider_modification_timestamp: 'ProviderModificationTimestamp',
        photo_modification_timestamp: 'PhotoModificationTimestamp',
        last_change_timestamp: 'LastChangeTimestamp',
        original_entry_timestamp: 'OriginalEntryTimestamp',
        bedrooms: 'BedsTotal',
        bathrooms: 'BathsTotal',
        year_built: 'YearBuilt',
        property_type: 'PropertyType',
        property_subtype: 'PropertySubType',
        postal_code: 'PostalCode',
        status: 'Status',
      }
    end

    def office_map
      {
        :city => '1608',
        :state => '1609',
        :address => '1645',
        :city_and_state => '1647',
        :last_transaction_code => '1650',
        :last_transaction_date => 'last_change_timestamp',
        :code => '1652',
        :name => '1653',
        :phone => '1654',
        :flag => '1658',
        :zip => '1659',
        :broker => '2217',
        :broker_name => '2533'
      }
    end

    def user_map
      {
        :address => '1661',
        :office_phone => '1661',
        :access_flag => '1664',
        :city => '1669',
        :state => '1670',
        :first_name => '1715',
        :fax => '1716',
        :last_name => '1717',
        :last_transaction_code => '1718',
        :last_transaction_timestamp => 'last_change_timestamp',
        :office_code => '1720',
        :roster_flag => '1724',
        :agentcode => '1727',
        :zipcode => '1730',
        :license_number => '2271',
        :agent_fullname => '2551'
      }
    end

    def open_house_map
      {
        :address_line_1 => '1660',
        :office_phone => '1661',
        :access_flag => '1664',
        :city => '1669',
        :state => '1670',
        :first_name => '1715',
        :agent_phone => '1716',
        :last_name => '1717',
        :last_transaction_code => '1718',
        :last_transaction_timestamp => 'last_change_timestamp',
        :office_code => '1720',
        :roster_flag => '1724',
        :public_id => '1727',
        :zip_code => '1730',
        :license_number => '2271',
        :agent_full_name => '2551'
      }
    end

    def media_map
      {
        :ml_num => 'MLNumber',
        :image_type => 'ImageType',
        :shot_number => 'ShotNumber',
        :comments => 'Comments',
        :resource_name => 'ResourceName',
        :view_picture_id => 'ViewPictureID'
      }
    end

    # Take values like true and false, convert them to "Y" or "N". make collections into joint strings.
    def value_map(value)
      v = case value.class
      when Array
        value.join(',')
      when Range
        "#{value.first}-#{value.last}"
      when Hash
        if value.has_key?(:or)
          "|#{value[:or].join(',')}"
        elsif value.has_key?(:not)
          "~#{value[:not].join(',')}"
        end
      when TrueClass
        "Y"
      when FalseClass
        "N"
      else
        value
      end
      v
    end

  end
end
