; high order function
(define foo_h (lambda (x) (lambda (y) (* x y))))
; Think about this function like this: λ x. λ y. x * y
;((foo_h 4) 6)

; function takes two arguments
(define (foo x y) (* x y))
;(foo 4 6)

; recursive factorial
(define (factorial n) 
        (if (= n 0) 
           1 
          (* n (factorial (- n 1)))
        )
)
;(factorial 5)

; tail-recursive factorial
(define (fac x)
  (letrec
    ( ; rec param
     (fac-tr (lambda (x acc)
       (if (zero? x) acc
         (fac-tr (- x 1) (* x acc)))))
    )
    (fac-tr x 1) ; rec body
  )
)

;(fac 5)

; reverse a list
(define (rev ls)
  (letrec
    ( ; rec param
     (rev_acc (lambda (acc rv)
       (if (null? acc) rv
         (rev_acc (cdr acc) (cons (car acc) rv)))))
    )
    (rev_acc ls '()) ; rec body
 )
)

; foldl
(define (foldl f z ls)
  (cond
    ((null? ls) z)
    (else (foldl f (f (car ls) z) (cdr ls)))
    )
)

; redefine reverse
(define (rev ls) (foldl cons '() ls))

; map
(define (my_map fun lst)
  (cond
    ((null ? lst) '())
    (else (cons (fun (car lst))
       (map fun (cdr lst ))))
  )
)

; foldr
(define (foldr f z ls)
  (cond
    ((null? ls) z)
    (else (f (car ls) (foldr f z (cdr ls))))
    )
)

; redefine map
(define (my_map fun lst)
  (foldr (lambda (x y) (cons (fun x) y))
         '() lst
  )
)

; Helper function
(define (sqr n) (* n n))

; Unit tests
(#%require rackunit)

; fac
(check-equal?
 (fac 5)
 120)

; rev
(check-equal?
 (rev '())
 '())

(check-equal?
 (rev '(1 2 3))
 '(3 2 1))

; foldl
(check-equal?
 (foldl + 0 '(1 2 3 4))
 10)

(check-equal?
 (foldl (lambda (x z) (+ 1 z)) 0 '(1 2 3 4))
 4)

; map
(check-equal?
 (my_map sqr (my_map sqr '(1 2 3 4)))
 '(1 16 81 256))