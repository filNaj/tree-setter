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
        (identifier)*
        ")"
        @double_points
    )
)
