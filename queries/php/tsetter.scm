;; --------------
;; Variables
;; --------------
;; PHP variable declaration
;; Example:
;;      $foo = 1
;;      $bar = "hello"
(expression_statement
  (variable_name) @equals
  )

;; --------------
;; Associative Arrays
;; --------------
;; PHP Associative arrays
;; Example:
;;      $foo['bar'] = 0
(expression_statement
  (subscript_expression) @equals
  )


;; --------------
;; Statement/Expressions
;; --------------
;; PHP variable declaration
;; Example:
;;      $foo = 1;
((expression_statement) @semicolon)
