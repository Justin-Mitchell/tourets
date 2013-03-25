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
    
    # Giant Hash.
    # TODO: OPTIMIZE!!!! ZOMG! O_o
    # Maybe break this into a YAML file that will pick which keymap to use based on the current_connection?
    # I'm thinking maybe like a dictionary lookup. Figure out what each RETS server uses.
    # Also good to note that there are different data types, but they all are strings.
    # We could figure out a way to convert to Integer, or DateTime objects, etc... depending.
    # All results are esentially just strings. The comments below indicate what the value type should be by how it's formatted
    def key_map
      {        
        :id =>   'sysid',
        :property_type =>  '1',
        :approximate_acreage =>  '2',
        :zip_code =>  '10',
        :statuschangedate =>  '18',
        :actual_close_date =>  '25',
        :la_name =>  '26',
        :dishwasher_inc =>  '30',
        :disposal_included =>  '31',
        :refrigerator_included =>  '33',
        :dryer_utilities =>  '34',
        :area =>  '37',
        :three_qrtr_baths =>  '60',
        :full_baths =>  '61',
        :half_baths =>  '62',
        :baths_total =>  '63',
        :bath_downstairs_description =>  '64',
        :bedrooms =>  '68',
        :built_description =>  '72',
        :carport_description =>  '73',
        :carport =>  '74',
        :comp_days_on_market =>  '81',
        :contingency_desc =>  '84',
        :acceptance_date =>  '85',
        :cooling_fuel_description =>  '86',
        :county_name =>  '87',
        :second__bedroom_dimensions =>  '89',
        :third_bedroom_dimensions =>  '90',
        :forth_bedroom_dimensions =>  '91',
        :dining_room_dimensions =>  '92',
        :family_room_dimensions =>  '93',
        :fifth_bedroom_dimensions =>  '94',
        :living_room_dimensions =>  '95',
        :master_bedroom_dimensions =>  '96',
        :fifth_bedroom_description =>  '97',
        :dom =>  '101',
        :entry_date =>  '104',
        :fence =>  '112',
        :fireplaces =>  '113',
        :converted_garage =>  '120',
        :garage =>  '122',
        :images =>  '129',
        :internet__y_n =>  '130',
        :last_transaction_code =>  '134',
        :last_transaction_date =>  '135',
        :list_office_code =>  '137',
        :list_date =>  '138',
        :list_agent_public_id =>  '143',
        :list_price =>  '144',
        :lot_sqft =>  '154',
        :community_name =>  '155',
        :ml_num =>  '163',
        :lo_name =>  '171',
        :original_list_price =>  '173',
        :numden_other =>  '184',
        :property_condition =>  '202',
        :pvpool =>  '203',
        :record_delete_date =>  '205',
        :record_delete_flag =>  '207',
        :sale_price =>  '210',
        :buyer_broker =>  '211',
        :elementary_school_3_5 =>  '213',
        :high_school =>  '214',
        :jr_high_school =>  '215',
        :buyer_agent_public_id =>  '218',
        :sewer =>  '219',
        :numloft =>  '231',
        :sellers_contribution__ =>  '232',
        :sold_term =>  '233',
        :pvspa =>  '236',
        :approx_liv_area =>  '237',
        :status =>  '242',
        :subdivision_name =>  '247',
        :washer_dryer_location =>  '260',
        :water =>  '261',
        :year_built =>  '264',
        :zoning =>  '266',
        :property_description =>  '268',
        :garage_description =>  '269',
        :roof_description =>  '270',
        :lot_description =>  '271',
        :spa_description =>  '272',
        :pool_description =>  '273',
        :dining_room_description =>  '276',
        :family_room_description =>  '277',
        :kitchen_description =>  '278',
        :living_room_description =>  '279',
        :master_bath_desc =>  '280',
        :master_bedroom_description =>  '281',
        :second__bedroom_description =>  '282',
        :third_bedroom_description =>  '283',
        :forth_bedroom_description =>  '284',
        :oven_description =>  '289',
        :other_appliance_description =>  '290',
        :construction_description =>  '291',
        :interior_description =>  '292',
        :flooring_description =>  '293',
        :fireplace_description =>  '294',
        :fence_type =>  '295',
        :equestrian_description =>  '296',
        :house_faces =>  '297',
        :miscellaneous_description =>  '298',
        :exterior_description =>  '299',
        :landscape_description =>  '300',
        :heating_description =>  '301',
        :heating_fuel_description =>  '302',
        :cooling_system =>  '303',
        :utility_information =>  '304',
        :energy_description =>  '305',
        :est_clo_lse_dt =>  '1736',
        :idx =>  '1809',
        :virtual_tour_link =>  '2139',
        :last_image_trans_date =>  '2238',
        :metro_map_coor_xp =>  '2343',
        :metro_map_page_xp =>  '2345',
        :sp_sqft__w_cents_ =>  '2359',
        :sqft =>  '2361',
        :short_sale =>  '2369',
        :elementary_school_k_2 =>  '2377',
        :bedrooms__total_possible_num_ =>  '2379',
        :days_from_listing_to_close =>  '2381',
        :unitnumber =>  '2386',
        :assoc_comm_features_desc =>  '2388',
        :bath_downstairs__y_n =>  '2392',
        :bedroom_downstairs__y_n =>  '2394',
        :bldg_desc =>  '2414',
        :fireplace_location =>  '2422',
        :foreclosure_commenced_y_n =>  '2424',
        :furnishings_description =>  '2426',
        :great_room_y_n =>  '2428',
        :great_room_dimensions =>  '2430',
        :great_room_description =>  '2432',
        :parking_description =>  '2438',
        :washer_included_ =>  '2440',
        :dryer_included_ =>  '2442',
        :house_views =>  '2450',
        :property_subtype =>  '2452',
        :repo_reo_y_n =>  '2660',
        :public_address_y_n =>  '2858',
        :commentaryy_n =>  '2859',
        :avm_y_n =>  '2860',
        :public_address =>  '2861',
        :auction_date =>  '2878',
        :auction_type =>  '2879',
        :buyer_premium =>  '2880',
        :drivinglatitude =>  '2901',
        :drivinglongitude =>  '2902',
        :city =>  '2909'        
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
        "Y" # TODO: figure out if this should be Y or Yes
      when FalseClass
        "N" # TODO: figure out if this should be N or No
      else
        value
      end
      v
    end
    
  end
end