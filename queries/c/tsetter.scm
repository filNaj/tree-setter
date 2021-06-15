;; For known declarations and initialisations
;; Example:
;;      char var_name
;;      int var_name = 10
;; Somehow `long` can't be seen as a declaration first, only if the semicolon is
;; added, so we have to use the query below for these cases.
(declaration
    type: [(primitive_type) (sized_type_specifier)]
    declarator: (_) @semicolon
)

;; Query for "special" variable declaration like the `long` type as descriped
;; above.
;; Example:
;;      long var_name
(sized_type_specifier
    type: (_) @semicolon
)

;; Adds semicolon for function calls.
;; Example:
;;      my_func()
((ERROR
    (call_expression
        function: (identifier)
        arguments: (argument_list) @semicolon
    )
) @test_case)

;; This is used for known functions like
;;      printf("welp")
;; Somehow the query above doesn't hit for `printf` for example, that's why we
;; need this query as well.
(expression_statement
    (call_expression
        function: (identifier)
        arguments: (argument_list) @semicolon
    )
)
