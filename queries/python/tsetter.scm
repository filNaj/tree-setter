;; --------------
;; Variables
;; --------------
;; Skip async function declarations
;; Example:
;;      async def
(expression_statement
  (identifier) @skip
  (#lua-match? @skip "^async%s*$")
)

;; Skip await expressions
;; Example:
;;      await func()
(expression_statement
  (identifier) @skip
  (#lua-match? @skip "^await%s*$")
)

;; For declarations and initialisations
;; Example:
;;      var_name = 10
(expression_statement
  (identifier) @equals
)

;; For declarations using the 'self' keyword
;; Example:
;;      self.x = 12
(expression_statement
  (attribute) @equals
)

;; For index declarations
;; Example:
;;      foo = ["bar"]
;;      foo[0]
(expression_statement
  (subscript) @equals
)


;; ====================
;; Lists and Dicts
;; ====================
;; This query is used for multiline lists and dicts like these:
;;
;;      int_list = [        my_dict = {
;;          1,                  1 : "value1",
;;          2,                  2 : "value2",
;;          3                   2 : "value3"
;;      ]                   }
;; But this can also be used for writing something like this:
;;
;;      int_list [        my_dict {
;;          1,                  1 : "value1",
;;          2,                  2 : "value2",
;;          3                   2 : "value3"
;;      ]                   }
(ERROR
    (identifier) ["[" "{"] (_) @comma
)


;; ========================
;; Classes and Methods
;; ========================
;; This is used for class declarations like
;;
;;      class TestClass
((ERROR "class" (identifier) .) @double_points)

;; Used for class methods like
;;
;;      def test(self)
(
    ("def")
    (identifier)
    (parameters
        (identifier)*  ;; it doesn't care how long the parameter list is
        ")"
        @double_points
    )
)
