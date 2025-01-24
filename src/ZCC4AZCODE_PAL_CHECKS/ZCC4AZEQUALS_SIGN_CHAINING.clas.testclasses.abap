class ltcl_test definition final for testing
  duration short
  risk level harmless
  friends ZCC4AZEQUALS_SIGN_CHAINING.

  private section.
    constants:
      begin of co_test_object,
        object_type type if_ci_atc_check=>ty_object-type value 'CLAS',
        object_name type if_ci_atc_check=>ty_object-name value 'ZCC4AZTEST_EQUAL_SIGN_CHAINING',
      end of co_test_object.
    constants:
      begin of co_test_method_name,
        finding_1 type cl_ci_atc_unit_driver=>ty_method_name value 'FINDING_1',
        finding_2 type cl_ci_atc_unit_driver=>ty_method_name value 'FINDING_2',
        finding_3 type cl_ci_atc_unit_driver=>ty_method_name value 'FINDING_3',
        finding_4 type cl_ci_atc_unit_driver=>ty_method_name value 'FINDING_4',
      end of co_test_method_name.


    methods run_test_check_findings for testing raising cx_static_check.

endclass.


class ltcl_test implementation.

  method run_test_check_findings.

    " Location and quickfixes of expected findings
    data(finding_1_obj) = cl_ci_atc_unit_driver=>get_method_object(
      value #( class = co_test_object-object_name method = co_test_method_name-finding_1 ) ).
    data(finding_1_loc) = value if_ci_atc_check=>ty_location(
      object = finding_1_obj
      position = value #( line = 7 column = 4 ) ).
    data(qf1_finding_1) = value if_ci_atc_unit_asserter=>ty_expected_quickfixes(
      ( code = value #(
          ( |C = D.| )
          ( |B = C.| )
          ( |A = B.| ) )
        location = finding_1_loc
        quickfix_code = ZCC4AZEQUALS_SIGN_CHAINING=>quickfix_codes-break_chain ) ).
    data(finding_2_obj) = cl_ci_atc_unit_driver=>get_method_object(
      value #( class  = co_test_object-object_name method = co_test_method_name-finding_2 ) ).
    data(finding_2_loc) = value if_ci_atc_check=>ty_location(
      object = finding_2_obj
      position = value #( line = 6 column = 4 ) ).
    data(qf1_finding_2) = value if_ci_atc_unit_asserter=>ty_expected_quickfixes(
      ( code = value #(
          ( |B = CONV #( c ).| )
          ( |A = B.| ) )
        location = finding_1_loc
        quickfix_code = ZCC4AZEQUALS_SIGN_CHAINING=>quickfix_codes-break_chain ) ).
    " Finding 3 should not appear due to the pseudo comment
    data(finding_4_obj) = cl_ci_atc_unit_driver=>get_method_object(
      value #( class  = co_test_object-object_name method = co_test_method_name-finding_4 ) ).
    data(finding_4_loc) = value if_ci_atc_check=>ty_location(
      object = finding_4_obj
      position = value #( line   = 7 column = 6 ) ).
    data(qf1_finding_4) = value if_ci_atc_unit_asserter=>ty_expected_quickfixes(
      ( code = value #(
          ( |B = C.| )
          ( |A = B.| ) )
        location = finding_4_loc
        quickfix_code = ZCC4AZEQUALS_SIGN_CHAINING=>quickfix_codes-break_chain ) ).

    cl_ci_atc_unit_driver=>create_asserter( )->check_and_assert(
      check             = new ZCC4AZEQUALS_SIGN_CHAINING( )
      object            = value #( name = co_test_object-object_name
                                   type = co_test_object-object_type )
      asserter_config   = value #( quickfixes                 = abap_false
                                   remove_findings_with_pcoms = abap_true )
      expected_findings = value #( ( code       = ZCC4AZEQUALS_SIGN_CHAINING=>finding_codes-equals_sign_chaining
                                     location   = finding_1_loc
                                     quickfixes = qf1_finding_1 )
                                   ( code       = ZCC4AZEQUALS_SIGN_CHAINING=>finding_codes-equals_sign_chaining
                                     location   = finding_2_loc
                                     quickfixes = qf1_finding_2 )
                                   ( code       = ZCC4AZEQUALS_SIGN_CHAINING=>finding_codes-equals_sign_chaining
                                     location   = finding_4_loc
                                     quickfixes = qf1_finding_4 ) ) ).

  endmethod.

endclass.
