
; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2013                              *
; *********************************************


;; -----------------------------------------------------
;; character to value mapping

(define ctv
  (lambda (x)
    (cond
      ((eq? x 'a) 1)
      ((eq? x 'b) 2)
      ((eq? x 'c) 3)
      ((eq? x 'd) 4)
      ((eq? x 'e) 5)
      ((eq? x 'f) 6)
      ((eq? x 'g) 7)
      ((eq? x 'h) 8)
      ((eq? x 'i) 9)
      ((eq? x 'j) 10)
      ((eq? x 'k) 11)
      ((eq? x 'l) 12)
      ((eq? x 'm) 13)
      ((eq? x 'n) 14)
      ((eq? x 'o) 15)
      ((eq? x 'p) 16)
      ((eq? x 'q) 17)
      ((eq? x 'r) 18)
      ((eq? x 's) 19)
      ((eq? x 't) 20)
      ((eq? x 'u) 21)
      ((eq? x 'v) 22)
      ((eq? x 'w) 23)
      ((eq? x 'x) 24)
      ((eq? x 'y) 25)
      ((eq? x 'z) 26))))

;; -----------------------------------------------------
;; Magic constant A used in multiplication methos
;;

(define A 0.6180339887)

(define reduce
  (lambda (op l id)
    (if (null? l)
       id
       (op (car l) (reduce op (cdr l) id)) )))

