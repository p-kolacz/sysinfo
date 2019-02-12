;;; sysinfo.el --- summary -*- lexical-binding: t -*-

;; Author: Piotr Kołacz
;; Maintainer: Piotr Kołacz
;; Version: 0.1.0
;; Homepage: https://github.com/p-kolacz/sysinfo


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; commentary

;;; Code:

(defvar sysinfo-os-family nil "Operatng system family, ex.: Linux, Windows, macOS.")
(defvar sysinfo-os-type nil "Operating system type, ex.: Android, WSL, cygwin.")

(let* ((families '(aix (AIX AIX)
                       berkeley-unix (BSD BSD)
                       cygwin (Windows cygwin)
                       darwin (macOS macOS)
                       gnu (GNU GNU)
                       gnu/linux (Linux (lambda() (let ((uname (shell-command-to-string "uname -a")))
                                               (cond ((string-match  "Linux.*Microsoft" uname) 'WSL)
                                                     ((string-match  "Linux.*Android" uname) 'Android)
                                                     (t 'Linux)
                                                     ))))
                       gnu/kfreebsd (FreeBSD FreeBSD)
                       hpux (HP-UX HP-UX)
                       nacl (NaCl NaCl)
                       ms-dos (MS-DOS MS-DOS)
                       usg-unix-v (SystemV SystemV)
                       windows-nt (Windows mingw)
                       ))
       (x (plist-get families system-type)))
  
  (setq sysinfo-os-family (car x))
  (setq sysinfo-os-type (if (functionp (cadr x))
                            (apply (cdr x))
                          (cadr x)
                          )))
  

(provide 'sysinfo)

;;; sysinfo.el ends here
