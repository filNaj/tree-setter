;; ===================
;; Action Queries
;; ===================
;; --------------
;; Variables
;; --------------
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

;; --------------
;; Functions
;; --------------
;; Example:
;;      my_func()
;;      printf()

;; This query might look weird for a function call but the query looks like
;; this if we just write 'function_call()'. Don't believe me? Try it out by
;; adding this for example in a C file:
;;      
;;      int main() {
;;          function_call()
;;      }
;;
;; and open the TreeSitterPlayground afterwards ;)
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

;; ----------------
;; Switch-Case
;; ----------------
;; Query for case statements like
;;      case 1
(case_statement
    value: (_) @double_points
)

;; ----------------------
;; Other expressions
;; ----------------------
;; Small updates, for example like
;;      integer--
;;  or  integer++
(update_expression
    argument: (_) @semicolon
)

;; ---------------------
;; Return statement
;; ---------------------
;; Well... just return statements... like
;;      return 0
(return_statement
    (_) @semicolon
)

;; ==========
;; Skips
;; ==========
;; If we are in a condition, than musn't add a semicolon in it! For example
;;      if (test()
;; So here are all "exception" cases. We have the query `ERROR` here, because if
;; we have a condition like
;;      if (...
;; Then we're having `ERROR` instead of `if_statement` since treesitter can't
;; detect it as an if-statement.
(ERROR ["if" "while" "for"] "(" @skip)
