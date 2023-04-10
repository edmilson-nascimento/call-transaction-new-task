
report  zreport.

parameters:
  tcode type sy-tcode obligatory,
  parid type rfc_spagpa-parid obligatory,
  vbeln type vbak-vbeln obligatory .

start-of-selection .

  perform tcode_new_task
    using tcode parid vbeln .


*----------------------------------------------------------------------*
*-      Form  tcode_new_task
*----------------------------------------------------------------------*
form tcode_new_task using tcode
        parid
        parval .

  data:
    spagpa_tab  type table of  rfc_spagpa,
    spagpa_line type rfc_spagpa.


  if ( tcode is  initial ) or
     ( parid is  initial ) or
     ( parval is initial )  .
    return .
  endif .  

  translate tcode to upper case .
  translate parid to upper case .

  spagpa_line-parid  = parid .
  spagpa_line-parval = parval .
  append spagpa_line to spagpa_tab .
  clear  spagpa_line .

  call function 'ABAP4_CALL_TRANSACTION' starting new task 'ZTEST'
    exporting
      tcode                         = tcode
      skip_screen                   = 'X'
      mode_val                      = 'A'
      update_val                    = 'A'
    tables
      spagpa_tab                    = spagpa_tab .

endform .                    "tcode_new_task
