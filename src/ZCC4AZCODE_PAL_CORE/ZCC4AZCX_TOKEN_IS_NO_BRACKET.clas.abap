class ZCC4AZCX_TOKEN_IS_NO_BRACKET definition
  public
  inheriting from cx_dynamic_check
  final
  create public .

  public section.

  methods constructor.
  protected section.
  private section.
ENDCLASS.



CLASS ZCC4AZCX_TOKEN_IS_NO_BRACKET IMPLEMENTATION.


  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( textid = textid previous = previous ).

  endmethod.
ENDCLASS.
