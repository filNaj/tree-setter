Thank you for wanting to contribute to *tree-setter*!
There are different ways to contribute to this project. Pick up the section if
the title suits your intention.

# Write Queries
## General
There's a little "tutorial" in the [wiki] for writing it. Take a look into it!

## Query-Code-Style
Please write the queries in the following style:

```scheme
<Look first, if there is a suitable sub-section where you could add your Query>
;; <Short description of its usage>
;; Example(s):
;;      <a short example which should be triggered>
;;
;; <If needed: A little description if there are "corner cases" or other stuff
;; which has to be considered>
<The query>
```

Here's an example of a C query of `tree-setter/queries/c/tsetter.scm`:

```scheme
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
    type: (_)
    declarator: (_) @semicolon
)
```

# Expanding/Improving tree-setter code
TODO
