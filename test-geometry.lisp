(defpackage :test-geometry (:use :common-lisp :2d-geometry :vecto)
	    (:export #:test-triangulate
		     #:test-decomposition))

(in-package :test-geometry)

(defun test-triangulate (polygon w h &optional (x 0) (y 0))
  (with-canvas (:width w :height h)
    (translate x y)
    (set-rgb-fill 0 0 0.8)
    (move-to (x (car polygon))(y (car polygon)))
    (dolist (tk polygon)
      (line-to (x tk)(y tk)))
    (line-to (x (car polygon))(y (car polygon)))
    (fill-path)
    (set-rgb-stroke 0 1.0 0)
    (set-line-width 2)
    (set-line-join :bevel)
    (dolist (tk (triangulate polygon))
      (move-to (x (car tk))(y (car tk)))
      (dolist (kk tk)
	(line-to (x kk)(y kk)))
      (line-to (x (car tk))(y (car tk))))
    (stroke)
    (save-png "test-geometry.png")))

(defun test-decompose (polygon w h &optional (x 0) (y 0))
  (with-canvas (:width w :height h)
    (translate x y)
    (set-rgba-fill 0 0 0.8 1.0)
    (set-rgba-stroke 0 0.8 0 0.5)
    (move-to (x (car polygon))(y (car polygon)))
    (dolist (tk polygon)
      (line-to (x tk)(y tk)))
    (line-to (x (car polygon))(y (car polygon)))
    (fill-and-stroke)
    (let ((d-polys (decompose-complex-polygon-nondisjoint polygon)))
      (dolist (tk d-polys)
	(translate 100 0)
	(set-rgba-fill (random 1.0)(random 1.0)(random 1.0) 1.0)
	(move-to (x (car tk))(y (car tk)))
	(dolist (kk tk)
	  (line-to (x kk)(y kk)))
	(line-to (x (car tk))(y (car tk)))
	(fill-path)))
    (save-png "test-geometry.png")))