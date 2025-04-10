; extends

(redirected_statement
  redirect: (heredoc_redirect
  (heredoc_start) @_here
  (heredoc_body) @injection.content)

  (#eq? @_here "PYSCRIPT")
  (#set! injection.language "python")
  (#set! injection.include-children))
