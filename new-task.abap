*&---------------------------------------------------------------------*
*& Report  ZTESTE_ENJ
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report  zteste_enj.

parameters:
  tcode type sy-tcode obligatory,
  parid type rfc_spagpa-parid obligatory,
  vbeln type vbak-vbeln obligatory .

start-of-selection .

  perform tcode_new_task
    using tcode parid vbeln .


*&---------------------------------------------------------------------*
*&      Form  tcode_new_task
*&---------------------------------------------------------------------*
form tcode_new_task
  using tcode
        parid
        parval .

  data:
    spagpa_tab  type table of  rfc_spagpa,
    spagpa_line type rfc_spagpa.


  if ( tcode is not initial ) and
     ( parid is not initial ) and
     ( parval is not initial )  .

    translate tcode to upper case .
    translate parid to upper case .

    spagpa_line-parid  = parid .
    spagpa_line-parval = parval .
    append spagpa_line to spagpa_tab .
    clear  spagpa_line .

    call function 'ABAP4_CALL_TRANSACTION' starting new task 'TEST'
      exporting
        tcode                         = tcode
        skip_screen                   = 'X'
        mode_val                      = 'A'
        update_val                    = 'A'
*     importing
*       subrc                         =
      tables
*       using_tab                     =
        spagpa_tab                    = spagpa_tab
*       mess_tab                      =
      exceptions
        call_transaction_denied       = 1
        tcode_invalid                 = 2
        others                        = 3 .

    if sy-subrc eq 0.
    else .
      message id sy-msgid type sy-msgty number sy-msgno
              with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    endif.

  endif .

endform .                    "tcode_new_task