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
(ERROR
    (call_expression
        function: (identifier)
        arguments: (argument_list) @semicolon
    )
)

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


;; If we are in a condition, than musn't add a semicolon in it! For example
;;      if (test()
;; So here are all "exception" cases. We have the query `ERROR` here, because if
;; we have a condition like
;;      if (...
;; Then we're having `ERROR` instead of `if_statement` since treesitter can't
;; detect it as an if-statement.
(ERROR ["if" "while" "for" "else"] "(" @skip)
