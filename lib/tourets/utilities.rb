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
        :id => 'sysid',
        :property_type => '1',
        :res_approximate_acreage => '2',
        :zip_code => '10',
        :res_statuschangedate => '18',
        :actual_close_date => '25',
        :la_name => '26',
        :res_dishwasher_inc => '30',
        :res_disposal_included => '31',
        :res_refrigerator_included => '33',
        :res_dryer_utilities => '34',
        :area => '37',
        :res__3_4_baths => '60',
        :res_full_baths => '61',
        :res_half_baths => '62',
        :res_baths_total => '63',
        :res_bath_downstairs_description => '64',
        :bedrooms => '68',
        :res_built_description => '72',
        :res_carport_description => '73',
        :res_carport => '74',
        :comp_days_on_market => '81',
        :res_contingency_desc => '84',
        :acceptance_date => '85',
        :res_cooling_fuel_description => '86',
        :county_name => '87',
        :res__2nd_bedroom_dimensions => '89',
        :res__3rd_bedroom_dimensions => '90',
        :res__4th_bedroom_dimensions => '91',
        :res_dining_room_dimensions => '92',
        :res_family_room_dimensions => '93',
        :res__5th_bedroom_dimensions => '94',
        :res_living_room_dimensions => '95',
        :res_master_bedroom_dimensions => '96',
        :res__5th_bedroom_description => '97',
        :dom => '101',
        :entry_date => '104',
        :res_fence => '112',
        :res_fireplaces => '113',
        :res_converted_garage => '120',
        :res_garage => '122',
        :images => '129',
        :res_internet__y_n => '130',
        :last_transaction_code => '134',
        :last_transaction_date => '135',
        :list_office_code => '137',
        :list_date => '138',
        :list_agent_public_id => '143',
        :list_price => '144',
        :res_lot_sqft => '154',
        :res_community_name => '155',
        :ml_num => '163',
        :res_lo_name => '171',
        :original_list_price => '173',
        :photo_instructions => '182',
        :res_num_den_other => '184',
        :res_property_condition => '202',
        :res_pvpool => '203',
        :record_delete_date => '205',
        :record_delete_flag => '207',
        :sale_price => '210',
        :buyer_broker => '211',
        :res_elementary_school_3_5 => '213',
        :res_high_school => '214',
        :res_jr_high_school => '215',
        :buyer_agent_public_id => '218',
        :res_sewer => '219',
        :res_num_loft => '231',
        :res_sellers_contribution_money => '232',
        :sold_term => '233',
        :res_pvspa => '236',
        :res_approx_liv_area => '237',
        :status => '242',
        :streetname => '243',
        :streetnumber => '244',
        :res_subdivision_name => '247',
        :res_washer_dryer_location => '260',
        :res_water => '261',
        :year_built => '264',
        :res_zoning => '266',
        :res_property_description => '268',
        :res_garage_description => '269',
        :res_roof_description => '270',
        :res_lot_description => '271',
        :res_spa_description => '272',
        :res_pool_description => '273',
        :res_dining_room_description => '276',
        :res_family_room_description => '277',
        :res_kitchen_description => '278',
        :res_living_room_description => '279',
        :res_master_bath_desc => '280',
        :res_master_bedroom_description => '281',
        :res__2nd_bedroom_description => '282',
        :res__3rd_bedroom_description => '283',
        :res__4th_bedroom_description => '284',
        :res_oven_description => '289',
        :res_other_appliance_description => '290',
        :res_construction_description => '291',
        :res_interior_description => '292',
        :res_flooring_description => '293',
        :res_fireplace_description => '294',
        :res_fence_type => '295',
        :res_equestrian_description => '296',
        :res_house_faces => '297',
        :res_miscellaneous_description => '298',
        :res_exterior_description => '299',
        :res_landscape_description => '300',
        :res_heating_description => '301',
        :res_heating_fuel_description => '302',
        :res_cooling_system => '303',
        :res_utility_information => '304',
        :res_energy_description => '305',
        :res_builder => '71',
        :res_built_desc => '72',
        :mul__1_bedroom__1__1_2_bath => '688',
        :mul__1_bedroom__1_bath => '689',
        :mul__1_bedroom_2_bath => '690',
        :mul__1_bedroom_rent => '692',
        :mul_num_1_bdrm_unfurn => '693',
        :mul__2_bedroom_1_1__2_bath => '694',
        :mul__2_bedroom_1_bath => '695',
        :mul__2_bedroom__2_bath => '696',
        :mul__2_bedroom_rent => '698',
        :mul_num_2_bdrm_unfurn => '699',
        :mul__3_bedroom_1_1_2_bath => '700',
        :mul__3_bedroom_1_bath => '701',
        :mul__3_bedroom_2_bath => '702',
        :mul__3_bedroom_rent => '704',
        :mul_num_3_bdrm_unfurn => '705',
        :mul_building_description => '732',
        :mul_built_description => '735',
        :mul_contingency_desc => '748',
        :mul_cost_per_unit => '750',
        :mul_flood_zone => '759',
        :mul_handicap_adapted => '770',
        :mul_heating_fuel_description => '771',
        :mul_internet__y_n => '773',
        :mul_maintenance => '782',
        :mul_management => '783',
        :mul_number_of_furnished_units => '796',
        :mul_num_floors => '798',
        :mul_lo_name => '802',
        :mul_total_num_of_parking_spaces => '808',
        :mul_property_condition => '816',
        :mul_sewer => '824',
        :mul_sold_down_payment => '831',
        :mul_approx_liv_area => '839',
        :mul_studio_1_1_2_bath => '844',
        :mul_studio_1_bath => '845',
        :mul_studio_2_bath => '846',
        :mul_studio_rent => '848',
        :mul_num_unfurn_studio => '849',
        :mul_subdivision_name => '850',
        :mul_num_bldgs => '853',
        :mul_num_units => '854',
        :mul_water => '860',
        :mul_financing_considered => '870',
        :mul_utilities_incl => '873',
        :mul_roof_description => '876',
        :mul_flooring_description => '877',
        :mul_construction_description => '878',
        :mul_parking_description => '879',
        :mul_other_appliance_description => '880',
        :mul_amentities_desc => '882',
        :mul_heating_description => '883',
        :mul_cooling_description => '884',
        :mul_separate_meter => '885',
        :mul_rent_terms_description => '889',
        :mul_directions => '890',
        :mul_built_desc => '735',
        :lnd_numg_acres => '892',
        :lnd_address_st_name => '893',
        :lnd_cash_to_assume => '915',
        :lnd_contingency_desc => '922',
        :lnd_flood_zone => '931',
        :lnd_internet__y_n => '941',
        :lnd_lot_depth => '944',
        :lnd_lot_frontage => '945',
        :lnd_num_parcels => '955',
        :lnd_lo_name => '957',
        :lnd_paved_road => '964',
        :lnd_price_per_acre => '970',
        :lnd_price_sacres => '971',
        :lnd_soil_report_available => '978',
        :lnd_sold_price_per_acre => '990',
        :lnd_state => '996',
        :lnd_total_ac => '1000',
        :lnd_zoning => '1009',
        :lnd_zoning_authority => '1010',
        :lnd_lot_description => '1011',
        :lnd_sewer => '1012',
        :lnd_water => '1013',
        :lnd_electricity => '1014',
        :lnd_gas_description => '1015',
        :lnd_map_description => '1018',
        :lnd_directions => '1019',
        :lnd_financing_considered => '1024',
        :rnt_compactor => '1463',
        :rnt_dishwasher => '1464',
        :rnt_disposal => '1465',
        :rnt_refrigerator => '1467',
        :rnt_dryer_utilities => '1468',
        :rnt__3_4_baths => '1469',
        :rnt_full_baths => '1470',
        :rnt_half_baths => '1471',
        :rnt_baths_total => '1472',
        :rnt_cable_available => '1474',
        :rnt_carports => '1475',
        :rnt_community_pool__y_n => '1483',
        :rnt_contingency_desc => '1487',
        :rnt_cooling_fuel_description => '1488',
        :rnt_date_available => '1489',
        :rnt_administration_deposit => '1490',
        :rnt_cleaning_deposit => '1491',
        :rnt_key_deposit => '1492',
        :rnt_pet_deposit => '1494',
        :rnt_fence => '1498',
        :rnt_num_fireplaces => '1499',
        :rnt_garage => '1505',
        :rnt_internet__y_n => '1507',
        :rnt_construction_description => '1509',
        :rnt_parking_description => '1510',
        :rnt_lot_description => '1511',
        :rnt_showing_agent_public_id => '1516',
        :rnt_metro_map_map_coor => '1523',
        :rnt_metro_map_map_page => '1524',
        :rnt_rented_price => '1526',
        :rnt_occupancy_description => '1530',
        :rnt_lo_name => '1531',
        :rnt_oven_description => '1533',
        :rnt_power_on_off => '1535',
        :rnt_condition => '1540',
        :rnt_private_pool => '1541',
        :rnt_cleaning_refund => '1545',
        :rnt_pet_refund => '1548',
        :rnt_elem_k_2 => '1551',
        :rnt_high_school => '1552',
        :rnt_jr_high_school => '1553',
        :rnt_spa => '1557',
        :rnt_approx_liv_area => '1558',
        :rnt_studio => '1563',
        :rnt_subdivision_name => '1564',
        :rnt_washer_dryer_included_ => '1569',
        :rnt_washer_dryer_location => '1570',
        :rnt_amentities_desc => '1573',
        :rnt_zoning => '1574',
        :rnt_style => '1575',
        :rnt_building_description => '1576',
        :rnt_pool_description => '1578',
        :rnt_din_fam_room_description => '1579',
        :rnt_spa_description => '1580',
        :rnt_deposit => '1581',
        :rnt_lease_description => '1582',
        :rnt_tenant_pays => '1583',
        :rnt_directions => '1584',
        :rnt_other_appliance_description => '1586',
        :rnt_interior_description => '1587',
        :rnt_master_bedroom_description => '1588',
        :rnt_living_room_description => '1589',
        :rnt_flooring_description => '1590',
        :rnt_kitchen_description => '1591',
        :rnt_exterior_description => '1592',
        :rnt_fireplace_description => '1593',
        :rnt_fence_type => '1596',
        :rnt_heating_description => '1597',
        :rnt_heating_fuel_description => '1598',
        :rnt_cooling_description => '1599',
        :rnt_sold_lease_description => '1601',
        :est_clo_lse_dt => '1736',
        :lp_sqft__w_cents_ => '1738',
        :rnt_furnished => '1748',
        :idx => '1809',
        :virtual_tour_link => '2139',
        :sp_sqft => '2140',
        :rnt_photo_inst => '2146',
        :last_image_trans_date => '2238',
        :lp_sqft => '2341',
        :res_metro_map_coor_xp => '2343',
        :res_metro_map_page_xp => '2345',
        :ver_subdivision_name_xp => '2353',
        :sp_sqft__w_cents_ => '2359',
        :sqft => '2361',
        :short_sale => '2369',
        :res_elementary_school_k_2 => '2377',
        :bedrooms__total_possible_num_ => '2379',
        :days_from_listing_to_close => '2381',
        :unitnumber => '2386',
        :res_amentities_desc => '2388',
        :res_bath_downstairs__y_n => '2392',
        :res_bedroom_downstairs__y_n => '2394',
        :res_bldg_desc => '2414',
        :res_fireplace_location => '2422',
        :res_foreclosure_commenced_y_n => '2424',
        :res_furnishings_description => '2426',
        :res_great_room_y_n => '2428',
        :res_great_room_dimensions => '2430',
        :res_great_room_description => '2432',
        :res_parking_description => '2438',
        :res_washer_included_ => '2440',
        :res_dryer_included_ => '2442',
        :res_house_views => '2450',
        :res_property_subtype => '2452',
        :mul_lot_square_foot => '2515',
        :mul_num_acres => '2529',
        :mul_seller_contribution => '2545',
        :rnt_condo_conversion_y_n => '2549',
        :rnt_loft_dim_1st_floor => '2555',
        :rnt__5th_bedroom_description => '2564',
        :rnt__4th_bedroom_description => '2566',
        :rnt_loft_dim_2nd_floor => '2567',
        :rnt_bath_down_y_n => '2569',
        :rnt_loft_description => '2570',
        :rnt__3rd_bedroom_description => '2571',
        :rnt_building_num => '2572',
        :rnt_unit_description => '2574',
        :rnt_approx_addl_liv_area => '2576',
        :rnt_bath_down_description => '2579',
        :rnt_den_dimensions => '2580',
        :rnt__4th_bedroom_dimensions => '2584',
        :rnt__5th_bedroom_dimensions => '2585',
        :rnt__3rd_bedroom_dimensions => '2586',
        :rnt__2nd_bedroom_dimensions => '2587',
        :rnt__2nd_bedroom_description => '2588',
        :rnt_master_bath_description => '2590',
        :rnt_furnished_description => '2591',
        :rnt_numden_other => '2592',
        :rnt_numloft => '2593',
        :rnt_lot_square_footage => '2594',
        :rnt_property_description => '2595',
        :rnt_family_room_dimensions => '2597',
        :rnt_great_room_dimensions => '2598',
        :rnt_great_room_y_n => '2599',
        :rnt_great_room_description => '2600',
        :rnt_dining_room_dimensions => '2601',
        :rnt_dining_room_description => '2602',
        :rnt_utility_information => '2604',
        :rnt_rent_range => '2607',
        :rnt_master_bedroom_dimensions => '2615',
        :rnt_garage_desc => '2616',
        :rnt_manufactured => '2617',
        :rnt_loft_dimensions => '2618',
        :rnt_family_room_description => '2622',
        :rnt_living_room_dimensions => '2623',
        :rnt_elem_3_5 => '2625',
        :rnt_converted_garage_y_n => '2627',
        :ladom => '2655',
        :rnt_bedroom_downstairs__y_n => '2657',
        :rnt_pets_allowed => '2889',
        :res_repo_reo_y_n => '2660',
        :ver_building_number => '2664',
        :ver_total_floors => '2665',
        :ver_elevator_floor_num => '2667',
        :ver_model => '2669',
        :ver_built_description => '2670',
        :ver_location => '2671',
        :ver_tower_name => '2672',
        :ver_amentities_desc => '2677',
        :ver_elementary_school_3_5 => '2678',
        :ver_elementary_school_k_2 => '2679',
        :ver_high_school => '2680',
        :ver_jr_high_school => '2681',
        :ver_metro_map_coor => '2683',
        :ver_metro_map_page => '2684',
        :ver_building_description => '2685',
        :ver_unit_levels => '2686',
        :ver_junior_suite__under_600_sqft_ => '2687',
        :ver_full_baths => '2688',
        :ver__3_4_baths => '2689',
        :ver_baths_total => '2690',
        :ver_half_baths => '2691',
        :ver_unit_description => '2692',
        :ver_condo_conversion => '2693',
        :ver_approx_liv_area => '2694',
        :ver_numden_other => '2695',
        :ver_private_pool => '2696',
        :ver_unit_pool_indoor => '2697',
        :ver_private_spa => '2698',
        :ver_unit_spa_indoor => '2699',
        :ver_num_of_loft_areas => '2700',
        :ver_parking_description => '2701',
        :ver_num_of_parking_spaces_included => '2702',
        :ver_parking_level => '2703',
        :ver_directions => '2705',
        :ver_living_room_description => '2708',
        :ver_living_room_dimensions => '2709',
        :ver_great_room_description => '2710',
        :ver_great_room_dimensions => '2711',
        :ver_media_room_y_n => '2712',
        :ver_media_room_dimensions => '2713',
        :ver_dining_room_description => '2714',
        :ver_dining_room_dimensions => '2715',
        :ver_kitchen_description => '2716',
        :ver_kitchen_flooring => '2717',
        :ver_kitchen_countertops => '2718',
        :ver_master_bedroom_description => '2719',
        :ver_master_bedroom_dimensions => '2720',
        :ver_master_bath_description => '2721',
        :ver__2nd_bedroom_description => '2722',
        :ver__2nd_bedroom_dimensions => '2723',
        :ver__3rd_bedroom_description => '2724',
        :ver__3rd_bedroom_dimensions => '2725',
        :ver__4th_bedroom_description => '2726',
        :ver__4th_bedroom_dimensions => '2727',
        :ver__5th_bedroom_description => '2728',
        :ver__5th_bedroom_dimensions => '2729',
        :ver_den_other_dimensions => '2730',
        :ver_loft_area_dimensions => '2731',
        :ver_loft_dimensions_1st_floor => '2732',
        :ver_loft_dimensions_2nd_floor => '2733',
        :ver_loft_description => '2734',
        :ver_furnishings_description => '2735',
        :ver_num_terraces => '2736',
        :ver_terrace_total_sqft => '2737',
        :ver_terrace_location => '2738',
        :ver_refrigerator_included => '2739',
        :ver_refrigerator_description => '2740',
        :ver_disposal_included => '2741',
        :ver_washer_included => '2742',
        :ver_dryer_included => '2743',
        :ver_dryer_utilities => '2744',
        :ver_washer_dryer_location => '2745',
        :ver_washer_dryer_description => '2746',
        :ver_dishwasher_included => '2747',
        :ver_dishwasher_description => '2748',
        :ver_other_appliances => '2749',
        :ver_oven_description => '2750',
        :ver_interior => '2751',
        :ver_flooring => '2752',
        :ver_fireplace => '2753',
        :ver_fireplace_description => '2754',
        :ver_fireplace_location => '2755',
        :ver_primary_view_direction => '2756',
        :ver_views => '2757',
        :ver_exterior_unit_description => '2758',
        :ver_heating_description => '2760',
        :ver_heating_fuel => '2761',
        :ver_cooling_fuel => '2763',
        :ver_cooling_system => '2764',
        :ver_energy_description => '2765',
        :ver_utility_information => '2766',
        :ver_leed_certified => '2768',
        :ver_num_storage_units => '2769',
        :ver_storage_unit_desc => '2770',
        :ver_on_site_staff_includes => '2775',
        :ver_services_available_on_site => '2776',
        :ver_security => '2777',
        :ver_assoc_fee_includes => '2787',
        :ver_pets_allowed => '2789',
        :ver_pet_description => '2790',
        :ver_pet_weight_limit => '2791',
        :ver_num_of_pets_allowed => '2792',
        :ver_foreclosure_commenced_y_n => '2804',
        :ver_financing_considered => '2806',
        :ver_possession_description => '2807',
        :ver_internet__y_n => '2810',
        :ver_lo_name => '2813',
        :ver_power_on_or_off => '2826',
        :ver_contingency_desc => '2829',
        :ver_sellers_contribution__ => '2830',
        :ver_property_condition => '2832',
        :ver_builder => '2668',
        :ver_built_desc => '2670',
        :lnd_subdivision_name => '2836',
        :foreclosure_commenced_y_n => '2837',
        :repo_reo_y_n => '2838',
        :ver_great_room_y_n => '2840',
        :ver_repo_reo_y_n => '2843',
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
    
    def office_map
      {
        :city => '1608',
        :state => '1609',
        :address => '1645',
        :city_and_state => '1647',
        :last_transaction_code => '1650',
        :last_transaction_date => '1651',
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
        :last_transaction_timestamp => '1719',
        :office_code => '1720',
        :roster_flag => '1724',
        :agentcode => '1727',
        :zipcode => '1730',
        :license_number => '2271',
        :agent_fullname => '2551'
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
