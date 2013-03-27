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
        :id => 'sysid', #String
        :property_type => '1', #String
        :approximate_acreage => '2', #Float
        :zip_code => '10', #String
        :statuschangedate => '18', #Datetime
        :actual_close_date => '25', #Datetime
        :la_name => '26', #String
        :dishwasher_inc => '30', #Boolean
        :disposal_included => '31', #Boolean
        :refrigerator_included => '33', #Boolean
        :dryer_utilities => '34', #String
        :area => '37', #String
        :_3_4_baths => '60', #Integer
        :full_baths => '61', #Integer
        :half_baths => '62', #Integer
        :baths_total => '63', #Integer
        :bath_downstairs_description => '64', #String
        :bedrooms => '68', #Integer
        :built_description => '72', #String
        :carport_description => '73', #String
        :carport => '74', #Integer
        :comp_days_on_market => '81', #Integer
        :contingency_desc => '84', #Datetime
        :acceptance_date => '85', #Datetime
        :cooling_fuel_description => '86', #String
        :county_name => '87', #String
        :_2nd_bedroom_dimensions => '89', #String
        :_3rd_bedroom_dimensions => '90', #String
        :_4th_bedroom_dimensions => '91', #String
        :dining_room_dimensions => '92', #String
        :family_room_dimensions => '93', #String
        :_5th_bedroom_dimensions => '94', #String
        :living_room_dimensions => '95', #String
        :master_bedroom_dimensions => '96', #String
        :_5th_bedroom_description => '97', #String
        :dom => '101',
        :entry_date => '104',
        :fence => '112',
        :fireplaces => '113',
        :converted_garage => '120',
        :garage => '122',
        :images => '129',
        :internet__y_n => '130',
        :last_transaction_code => '134',
        :last_transaction_date => '135',
        :list_office_code => '137', #String
        :list_date => '138', 
        :list_agent_public_id => '143',
        :list_price => '144',
        :lot_sqft => '154',
        :community_name => '155', #String
        :ml_num => '163',
        :lo_name => '171', #String
        :original_list_price => '173',
        :photo_instructions => '182', #String
        :num_den_other => '184',
        :property_condition => '202', #String
        :pvpool => '203',
        :record_delete_date => '205',
        :record_delete_flag => '207', #String
        :sale_price => '210',
        :buyer_broker => '211', #String
        :elementary_school_3_5 => '213', #String
        :high_school => '214', #String
        :jr_high_school => '215', #String
        :buyer_agent_public_id => '218', 
        :sewer => '219',
        :num_loft => '231',
        :sellers_contribution_money => '232',
        :sold_term => '233', #String
        :pvspa => '236',
        :approx_liv_area => '237',
        :status => '242', #String
        :subdivision_name => '247', #String
        :washer_dryer_location => '260', #String
        :water => '261',
        :year_built => '264',
        :zoning => '266', #String
        :property_description => '268', #String
        :garage_description => '269', #String
        :roof_description => '270', #String
        :lot_description => '271', #String
        :spa_description => '272', #String
        :pool_description => '273', #String
        :dining_room_description => '276', #String
        :family_room_description => '277', #String
        :kitchen_description => '278', #String
        :living_room_description => '279', #String
        :master_bath_desc => '280', #String
        :master_bedroom_description => '281', #String
        :_2nd_bedroom_description => '282', #String
        :_3rd_bedroom_description => '283', #String
        :_4th_bedroom_description => '284', #String
        :oven_description => '289', #String
        :other_appliance_description => '290', #String
        :construction_description => '291', #String
        :interior_description => '292', #String
        :flooring_description => '293', #String
        :fireplace_description => '294', #String
        :fence_type => '295', #String
        :equestrian_description => '296', #String
        :house_faces => '297', #String
        :miscellaneous_description => '298', #String
        :exterior_description => '299', #String
        :landscape_description => '300', #String
        :heating_description => '301', #String
        :heating_fuel_description => '302', #String
        :cooling_system => '303', #String
        :utility_information => '304', #String
        :energy_description => '305', #String
        :_1_bedroom__1__1_2_bath => '688', #Integer
        :_1_bedroom__1_bath => '689', #Integer
        :_1_bedroom_2_bath => '690', #Integer
        :_1_bedroom_rent => '692', #Integer
        :num_1_bdrm_unfurn => '693', #Integer
        :_2_bedroom_1_1__2_bath => '694', #Integer
        :_2_bedroom_1_bath => '695', #Integer
        :_2_bedroom__2_bath => '696', #Integer
        :_2_bedroom_rent => '698', #Integer
        :num_2_bdrm_unfurn => '699', #Integer
        :_3_bedroom_1_1_2_bath => '700', #Integer
        :_3_bedroom_1_bath => '701', #Integer
        :_3_bedroom_2_bath => '702', #Integer
        :_3_bedroom_rent => '704', #Integer
        :num_3_bdrm_unfurn => '705', #Integer
        :building_description => '732', #String
        :built_description => '735', #String
        :contingency_desc => '748', #String
        :cost_per_unit => '750', #Integer
        :flood_zone => '759', #String
        :handicap_adapted => '770', #Boolean
        :heating_fuel_description => '771',
        :internet__y_n => '773',
        :maintenance => '782',
        :management => '783',
        :number_of_furnished_units => '796',
        :num_floors => '798',
        :lo_name => '802',
        :total_num_of_parking_spaces => '808',
        :property_condition => '816',
        :sewer => '824',
        :sold_down_payment => '831',
        :approx_liv_area => '839',
        :studio_1_1_2_bath => '844',
        :studio_1_bath => '845',
        :studio_2_bath => '846',
        :studio_rent => '848',
        :num_unfurn_studio => '849',
        :subdivision_name => '850',
        :num_bldgs => '853',
        :num_units => '854',
        :water => '860',
        :financing_considered => '870',
        :utilities_incl => '873',
        :roof_description => '876',
        :flooring_description => '877',
        :construction_description => '878',
        :parking_description => '879',
        :other_appliance_description => '880',
        :proj_amenities_description => '882',
        :heating_description => '883',
        :cooling_description => '884',
        :separate_meter => '885',
        :rent_terms_description => '889',
        :directions => '890',
        :numg_acres => '892',
        :address_st_name => '893',
        :cash_to_assume => '915',
        :contingency_desc => '922',
        :flood_zone => '931',
        :internet__y_n => '941',
        :lot_depth => '944',
        :lot_frontage => '945',
        :num_parcels => '955',
        :lo_name => '957',
        :paved_road => '964',
        :price_per_acre => '970',
        :price_sacres => '971',
        :soil_report_available => '978',
        :sold_price_per_acre => '990',
        :state => '996',
        :total_ac => '1000',
        :zoning => '1009',
        :zoning_authority => '1010',
        :lot_description => '1011',
        :sewer => '1012',
        :water => '1013',
        :electricity => '1014',
        :gas_description => '1015',
        :map_description => '1018',
        :directions => '1019',
        :financing_considered => '1024',
        :compactor => '1463',
        :dishwasher => '1464',
        :disposal => '1465',
        :refrigerator => '1467',
        :dryer_utilities => '1468',
        :_3_4_baths => '1469',
        :full_baths => '1470',
        :half_baths => '1471',
        :baths_total => '1472',
        :cable_available => '1474',
        :carports => '1475',
        :community_pool__y_n => '1483',
        :contingency_desc => '1487',
        :cooling_fuel_description => '1488',
        :date_available => '1489',
        :administration_deposit => '1490',
        :cleaning_deposit => '1491',
        :key_deposit => '1492',
        :fence => '1498',
        :num_fireplaces => '1499',
        :garage => '1505',
        :internet__y_n => '1507',
        :construction_description => '1509',
        :parking_description => '1510',
        :lot_description => '1511',
        :showing_agent_public_id => '1516',
        :metro_map_map_coor => '1523',
        :metro_map_map_page => '1524',
        :rented_price => '1526',
        :occupancy_description => '1530',
        :lo_name => '1531',
        :oven_description => '1533',
        :power_on_off => '1535',
        :condition => '1540',
        :private_pool => '1541',
        :cleaning_refund => '1545',
        :pet_refund => '1548',
        :elem_k_2 => '1551',
        :high_school => '1552',
        :jr_high_school => '1553',
        :spa => '1557',
        :approx_liv_area => '1558',
        :studio => '1563',
        :subdivision_name => '1564',
        :washer_dryer_included_ => '1569',
        :washer_dryer_location => '1570',
        :assoc_comm_features_desc => '1573',
        :zoning => '1574',
        :style => '1575',
        :building_description => '1576',
        :pool_description => '1578',
        :din_fam_room_description => '1579',
        :spa_description => '1580',
        :deposit => '1581',
        :lease_description => '1582',
        :tenant_pays => '1583',
        :directions => '1584',
        :other_appliance_description => '1586',
        :interior_description => '1587',
        :master_bedroom_description => '1588',
        :living_room_description => '1589',
        :flooring_description => '1590',
        :kitchen_description => '1591',
        :exterior_description => '1592',
        :fireplace_description => '1593',
        :fence_type => '1596',
        :heating_description => '1597',
        :heating_fuel_description => '1598',
        :cooling_description => '1599',
        :sold_lease_description => '1601',
        :est_clo_lse_dt => '1736',
        :lp_sqft__w_cents_ => '1738',
        :furnished => '1748',
        :idx => '1809',
        :virtual_tour_link => '2139',
        :sp_sqft => '2140',
        :photo_inst => '2146',
        :last_image_trans_date => '2238',
        :lp_sqft => '2341',
        :metro_map_coor_xp => '2343',
        :metro_map_page_xp => '2345',
        :subdivision_name_xp => '2353',
        :sp_sqft__w_cents_ => '2359',
        :sqft => '2361',
        :short_sale => '2369',
        :elementary_school_k_2 => '2377',
        :bedrooms__total_possible_num_ => '2379',
        :days_from_listing_to_close => '2381',
        :unitnumber => '2386',
        :assoc_comm_features_desc => '2388',
        :bath_downstairs__y_n => '2392',
        :bedroom_downstairs__y_n => '2394',
        :bldg_desc => '2414',
        :fireplace_location => '2422',
        :foreclosure_commenced_y_n => '2424',
        :furnishings_description => '2426',
        :great_room_y_n => '2428',
        :great_room_dimensions => '2430',
        :great_room_description => '2432',
        :parking_description => '2438',
        :washer_included_ => '2440',
        :dryer_included_ => '2442',
        :house_views => '2450',
        :property_subtype => '2452',
        :lot_square_foot => '2515',
        :num_acres => '2529',
        :seller_contribution => '2545',
        :condo_conversion_y_n => '2549',
        :loft_dim_1st_floor => '2555',
        :_5th_bedroom_description => '2564',
        :_4th_bedroom_description => '2566',
        :loft_dim_2nd_floor => '2567',
        :bath_down_y_n => '2569',
        :loft_description => '2570',
        :_3rd_bedroom_description => '2571',
        :building_num => '2572',
        :unit_description => '2574',
        :approx_addl_liv_area => '2576',
        :bath_down_description => '2579',
        :den_dimensions => '2580',
        :_4th_bedroom_dimensions => '2584',
        :_5th_bedroom_dimensions => '2585',
        :_3rd_bedroom_dimensions => '2586',
        :_2nd_bedroom_dimensions => '2587',
        :_2nd_bedroom_description => '2588',
        :master_bath_description => '2590',
        :furnished_description => '2591',
        :numden_other => '2592',
        :numloft => '2593',
        :lot_square_footage => '2594',
        :property_description => '2595',
        :family_room_dimensions => '2597',
        :great_room_dimensions => '2598',
        :great_room_y_n => '2599',
        :great_room_description => '2600',
        :dining_room_dimensions => '2601',
        :dining_room_description => '2602',
        :utility_information => '2604',
        :rent_range => '2607',
        :master_bedroom_dimensions => '2615',
        :garage_desc => '2616',
        :manufactured => '2617',
        :loft_dimensions => '2618',
        :family_room_description => '2622',
        :living_room_dimensions => '2623',
        :elem_3_5 => '2625',
        :converted_garage_y_n => '2627',
        :ladom => '2655',
        :bedroom_downstairs__y_n => '2657',
        :repo_reo_y_n => '2660',
        :building_number => '2664',
        :total_floors => '2665',
        :elevator_floor_num => '2667',
        :builder => '2668',
        :model => '2669',
        :built_description => '2670',
        :location => '2671',
        :tower_name => '2672',
        :association_features_available => '2677',
        :elementary_school_3_5 => '2678',
        :elementary_school_k_2 => '2679',
        :high_school => '2680',
        :jr_high_school => '2681',
        :metro_map_coor => '2683',
        :metro_map_page => '2684',
        :building_description => '2685',
        :unit_levels => '2686',
        :junior_suite__under_600_sqft_ => '2687',
        :full_baths => '2688',
        :_3_4_baths => '2689',
        :baths_total => '2690',
        :half_baths => '2691',
        :unit_description => '2692',
        :condo_conversion => '2693',
        :approx_liv_area => '2694',
        :numden_other => '2695',
        :private_pool => '2696',
        :unit_pool_indoor => '2697',
        :private_spa => '2698',
        :unit_spa_indoor => '2699',
        :num_of_loft_areas => '2700',
        :parking_description => '2701',
        :num_of_parking_spaces_included => '2702',
        :parking_level => '2703',
        :directions => '2705',
        :living_room_description => '2708',
        :living_room_dimensions => '2709',
        :great_room_description => '2710',
        :great_room_dimensions => '2711',
        :media_room_y_n => '2712',
        :media_room_dimensions => '2713',
        :dining_room_description => '2714',
        :dining_room_dimensions => '2715',
        :kitchen_description => '2716',
        :kitchen_flooring => '2717',
        :kitchen_countertops => '2718',
        :master_bedroom_description => '2719',
        :master_bedroom_dimensions => '2720',
        :master_bath_description => '2721',
        :_2nd_bedroom_description => '2722',
        :_2nd_bedroom_dimensions => '2723',
        :_3rd_bedroom_description => '2724',
        :_3rd_bedroom_dimensions => '2725',
        :_4th_bedroom_description => '2726',
        :_4th_bedroom_dimensions => '2727',
        :_5th_bedroom_description => '2728',
        :_5th_bedroom_dimensions => '2729',
        :den_other_dimensions => '2730',
        :loft_area_dimensions => '2731',
        :loft_dimensions_1st_floor => '2732',
        :loft_dimensions_2nd_floor => '2733',
        :loft_description => '2734',
        :furnishings_description => '2735',
        :num_terraces => '2736',
        :terrace_total_sqft => '2737',
        :terrace_location => '2738',
        :refrigerator_included => '2739',
        :refrigerator_description => '2740',
        :disposal_included => '2741',
        :washer_included => '2742',
        :dryer_included => '2743',
        :dryer_utilities => '2744',
        :washer_dryer_location => '2745',
        :washer_dryer_description => '2746',
        :dishwasher_included => '2747',
        :dishwasher_description => '2748',
        :other_appliances => '2749',
        :oven_description => '2750',
        :interior => '2751',
        :flooring => '2752',
        :fireplace => '2753',
        :fireplace_description => '2754',
        :fireplace_location => '2755',
        :primary_view_direction => '2756',
        :views => '2757',
        :exterior_unit_description => '2758',
        :heating_description => '2760',
        :heating_fuel => '2761',
        :cooling_fuel => '2763',
        :cooling_system => '2764',
        :energy_description => '2765',
        :utility_information => '2766',
        :leed_certified => '2768',
        :num_storage_units => '2769',
        :storage_unit_desc => '2770',
        :on_site_staff_includes => '2775',
        :services_available_on_site => '2776',
        :security => '2777',
        :assoc_fee_includes => '2787',
        :foreclosure_commenced_y_n => '2804',
        :financing_considered => '2806',
        :possession_description => '2807',
        :internet__y_n => '2810',
        :lo_name => '2813',
        :power_on_or_off => '2826',
        :contingency_desc => '2829',
        :sellers_contribution__ => '2830',
        :property_condition => '2832',
        :subdivision_name => '2836',
        :foreclosure_commenced_y_n => '2837',
        :repo_reo_y_n => '2838',
        :great_room_y_n => '2840',
        :repo_reo_y_n => '2843',
        :public_address_y_n => '2858',
        :commentaryy_n => '2859',
        :avm_y_n => '2860',
        :public_address => '2861',
        :sp_lp => '2864',
        :auction_date => '2878',
        :auction_type => '2879',
        :buyer_premium => '2880',
        :drivinglatitude => '2901',
        :drivinglongitude => '2902',
        :city => '2909'
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