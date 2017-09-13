# Call Transaction in new task

[![N|Solid](https://wiki.scn.sap.com/wiki/download/attachments/1710/ABAP%20Development.png?version=1&modificationDate=1446673897000&api=v2)](https://www.sap.com/brazil/developer.html)

Houve a necessidade de que fosse feito um `call transaction` mas este não poderia ser na mesma sessão/janela, pois se tratava de um popup de informação. Concordo que é muita informação em apenas uma mostra, mas para *simplificar* pensei em colocar para que o documento (no meu caso uma Ordem de Vendas para VA03) fosse em uma nova sessão.

  - Utilização de Função
  - Chamada de `call transaction`
  - Filtro para Ordem de Vendas informada na Selection-Screen
  
## Recuperação das informações 

```abap

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
   
 ```
