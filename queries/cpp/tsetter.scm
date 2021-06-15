; inherits: c
;; Since C and C++ have a similiar syntax, we're including the queries of here
;; as well.
;; ===============
;; Statements
;; ===============
;; Expression statements like
;;      std::cout << "TreeSetter, noice!" << std::endl
(binary_expression
    left: (_)
    right: (_) @semicolon_no_newline
)
