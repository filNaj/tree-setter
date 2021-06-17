;; ==============
;; Variables
;; ==============
;; A normal let declaration like
;;      
;;      let variable = 10
(let_declaration
    pattern: (identifier)
    value: (_) @semicolon
)

;; ==============
;; Functions
;; ==============
;; A normal function call like
;;
;;      test()
(call_expression
    function: (identifier)
    arguments: (arguments) @semicolon
)
