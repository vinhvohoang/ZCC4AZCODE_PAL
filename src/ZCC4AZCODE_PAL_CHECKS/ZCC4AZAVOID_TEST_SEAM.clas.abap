class ZCC4AZAVOID_TEST_SEAM definition
  public
  final
  create public .

  public section.
    interfaces if_ci_atc_check.

    constants:
      begin of finding_codes,
        test_seam type if_ci_atc_check=>ty_finding_code value 'TESTSEAMUS',
      end of finding_codes.

    methods constructor.

  protected section.
  private section.
    constants pseudo_comment type string value 'TEST_SEAM_USAGE'.

    data code_provider     type ref to if_ci_atc_source_code_provider.
    data assistant_factory type ref to cl_ci_atc_assistant_factory.
    data meta_data type ref to ZCC4AZIF_CHECK_META_DATA.

    methods analyze_procedure
      importing procedure       type if_ci_atc_source_code_provider=>ty_procedure
      returning value(findings) type if_ci_atc_check=>ty_findings.
ENDCLASS.



CLASS ZCC4AZAVOID_TEST_SEAM IMPLEMENTATION.


  method analyze_procedure.
    loop at procedure-statements assigning field-symbol(<statement>) where keyword eq 'TEST-SEAM' ##PRIMKEY[KEYWORD].
      insert value #( code = finding_codes-test_seam
      location = code_provider->get_statement_location( <statement> )
      checksum = code_provider->get_statement_checksum( <statement> )
      has_pseudo_comment = meta_data->has_valid_pseudo_comment(
        statement = <statement>
        finding_code = finding_codes-test_seam )
      ) into table findings.
    endloop.
  endmethod.


  method if_ci_atc_check~get_meta_data.
    meta_data = me->meta_data.
  endmethod.

  method constructor.
    meta_data = ZCC4AZCHECK_META_DATA=>create(
      value #( checked_types = ZCC4AZCHECK_META_DATA=>checked_types-abap_programs
          description = 'Usage of TEST-SEAM'(des)
          remote_enablement = ZCC4AZCHECK_META_DATA=>remote_enablement-unconditional
          finding_codes = value #(
            ( code = finding_codes-test_seam pseudo_comment = pseudo_comment text = 'Usage of TEST-SEAM'(uot) ) ) ) ).
  endmethod.


  method if_ci_atc_check~run.
    code_provider = data_provider->get_code_provider( ).
    data(procedures) = code_provider->get_procedures( code_provider->object_to_comp_unit( object ) ).
    loop at procedures->* assigning field-symbol(<procedure>).
      insert lines of analyze_procedure( <procedure> ) into table findings.
    endloop.
  endmethod.


  method if_ci_atc_check~set_assistant_factory.
    assistant_factory = factory.
  endmethod.


  method if_ci_atc_check~verify_prerequisites.

  endmethod.
ENDCLASS.
