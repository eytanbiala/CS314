
; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2013                              *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(load "include.ss")

;; contains simple dictionary definition
(load "test-dictionary.ss")
;(load "dictionary.ss")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

(define check
  (lambda (bitvector word)
    ;(display bitvector)
    ;(display word)
    (if (null? word) #t (check2 bitvector (car word)))))

(define check2
  (lambda (list el)
    (cond ((member el list) '#t) (else '#f))
    ))

(define dohashes
  (lambda (hashlist dict)
    (if (null? hashlist)
        '()
        (append (map (car hashlist) dict) (dohashes (cdr hashlist) dict)))))

;; -----------------------------------------------------
;; KEY FUNCTION

(define key
  (lambda (w)
    (if (null? w)
        5381
        (+ (ctv (car w)) ( * 33 (key (cdr w)))))
    ))


;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

;; value of parameter "size" should be a prime number
(define gen-hash-division-method
  (lambda (size) ;; range of values: 0..size-1
    (lambda (w)
      (modulo (key (reverse w)) size))
    ))

;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17

(define gen-hash-multiplication-method
  (lambda (size) ;; range of values: 0..size-1
    (lambda (w)
      (floor (* size (- (* (key (reverse w)) A) (floor (* (key (reverse w)) A)))))
      )))


;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 15485867))
(define hash-2 (gen-hash-division-method 32452843))
(define hash-3 (gen-hash-multiplication-method 32452867))
(define hash-4 (gen-hash-multiplication-method 49979687))

(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
(define hashfl-2 (list hash-1 hash-3))


;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;;  (hash-1 '(h e l l o)) ==> 657
;;  (hash-1 '(d a y))     ==> 46
;;  (hash-1 '(c l a s s)) ==> 183
;;
;;  (hash-2 '(h e l l o)) ==> 273
;;  (hash-2 '(d a y))     ==> 218
;;  (hash-2 '(c l a s s)) ==> 254
;;
;;  (hash-3 '(h e l l o)) ==> 595.0
;;  (hash-3 '(d a y))     ==> 546.0
;;  (hash-3 '(c l a s s)) ==> 169.0
;;
;;  (hash-4 '(h e l l o)) ==> 765.0
;;  (hash-4 '(d a y))     ==> 702.0
;;  (hash-4 '(c l a s s)) ==> 217.0


;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR

(define gen-checker
  (lambda (hashfunctionlist dict)
    (let ((bitvector (dohashes hashfunctionlist dict)))
      (lambda (w)         
        ;(if (equal? #t 
        (check bitvector (dohashes hashfunctionlist (list w)))
        ))))

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

(define checker-1 (gen-checker hashfl-1 dictionary))
(define checker-2 (gen-checker hashfl-2 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t
