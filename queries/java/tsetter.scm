;; local variables
;;      String s = "";
; Equals for variable declaration
;      int x =
(local_variable_declaration
  declarator: (_
    name: (_) @equals
  ) @semicolon
)

;; fields
;;      private Map<String, String> data;
(field_declaration
    declarator: (_) @semicolon
)

;; assignments
;;      this.data = new HashMap<>();
((expression_statement
    (assignment_expression
        left: (_)
        right: (_)
    )
) @semicolon)

;; functions calls 
;;      Ex: func()  
((expression_statement
  (_)
) @semicolon)

((ERROR
  (method_invocation
    name: (identifier)
    arguments: (argument_list)
  )
) @semicolon)

;; methods
;;      this.client.configure(config);
((expression_statement
    (method_invocation
        object: (_)
        name: (_)
        arguments: (_)
    )
) @semicolon)

;; return statements
;;      return 0;
((return_statement
    (_)
) @semicolon)

;; package declaration
;;      package example;
((package_declaration
    (_)
) @semicolon)

;; import
;;      import java.util.Map;
((import_declaration
    (_)
) @semicolon)
