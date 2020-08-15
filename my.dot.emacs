;; -*- Mode: Emacs-Lisp -*-

;; This file was written by Josef Ezra for his own use.
;; You are welcomed to use this file or any part of it at your own risk.

;;  Copyright (C) 2000-2020
;;  Josef Ezra jezra@cpan.org

;; no menubars, thank you. (gnu is not unix, and emacs is not xemacs)
( if  window-system ;; (>= emacs-major-version 28)
   ( let()
     (tool-bar-mode -1)
     (if (fboundp 'x-show-tip)
         (tooltip-mode  -1))
     (menu-bar-mode 0)
))

;; ============
;; Selective OS
;; ============
(if (string-match "linux" system-configuration)
;; linux
    (let ()

      )
;else
 (if (string-match "sun" system-configuration)
;; solaris
    (let ()
      (if (string-match (getenv "HOST") (getenv "DISPLAY"))
          ;; is it sun, displayed by sun ?
          (eval (set-default-font "-*-Lucida Sans Typewriter-Bold-r-*-*-*-140-72-72-*-*-iso8859-1"))
        (set-default-font "-*-*-bold-*-normal-*-*-140-*-*-*-*-iso8859-1"))
      )
;else
  (if (string-match "nt" system-configuration)
;; windows NT
      (let () 
;;        (setq my-home "e:/")
;;         (set-default-font "-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        )
)))

;; ==============
;; Self Adjusting
;; ==============

(global-set-key [(f9)]  'clipboard-kill-region)
(global-set-key [(f10)] 'clipboard-yank)
(global-set-key [(f11)] 'clipboard-kill-ring-save)
(global-set-key [(f12)] 'menu-bar-mode)
(global-set-key [(control shift k)] 'kill-whole-line)

(global-set-key [(control home  )]      'beginning-of-buffer )
(global-set-key [(control end   )]      'end-of-buffer )
(global-set-key [(        home  )]      'beginning-of-line )
(global-set-key [(        end   )]      'end-of-line )
(global-set-key [(control tab   )]      'other-window )
(global-set-key [(meta    g     )]      'goto-line )              ; overwrite
(global-set-key [(shift   tab   )]      'indent-relative-maybe)   ; overwrite tab
(global-set-key [(shift   iso-lefttab)] 'indent-relative-maybe)   ; overwrite tab
(global-set-key [(shift   S-iso-lefttab)] 'indent-relative-maybe) ; overwrite tab, again
(global-set-key [(control meta \;)]     'comment-region)
(global-set-key [(control delete)]      'delete-region )
(global-set-key [(control return)]      'dabbrev-expand)
(global-set-key [(meta    return)]      'ispell-complete-word)
(global-set-key [(control x)(r)(e)]     'apply-macro-to-region-lines) ; c-x (, ..., c-x-), c-x e / c-x r e
(global-set-key [(control     \!)]      'shell-command-on-region)

(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)

(global-set-key [(meta         down)] '(lambda() (interactive) (scroll-up 1)))
(global-set-key [(meta         up  )] '(lambda() (interactive) (scroll-down 1)))
(global-set-key [(meta control down)] '(lambda() (interactive) (scroll-other-window 1)))
(global-set-key [(meta control up  )] '(lambda() (interactive) (scroll-other-window-down 1)))
(global-set-key [(meta shift   down)] '(lambda() (interactive) (scroll-other-window 1)))
(global-set-key [(meta shift   up  )] '(lambda() (interactive) (scroll-other-window-down 1)))
(global-set-key [(          mouse-4)] '(lambda() (interactive) (scroll-down 4 )))
(global-set-key [(          mouse-5)] '(lambda() (interactive) (scroll-up   4 )))
(global-set-key [(   shift  mouse-4)] '(lambda() (interactive) (scroll-down 1 )))
(global-set-key [(   shift  mouse-5)] '(lambda() (interactive) (scroll-up   1 )))
(global-set-key [(  control mouse-4)] '(lambda() (interactive) (scroll-down   )))
(global-set-key [(  control mouse-5)] '(lambda() (interactive) (scroll-up     )))

(global-set-key [(meta control z   )] 'iconify-or-deiconify-frame )
(global-set-key [(     control z   )] 'undo )

(global-set-key [(control \,)] 'blink-matching-open) ;; Display the opening line as message

;; tags support
(global-set-key [(control \>)] 'tags-search )
(global-set-key [(control \.)] 'tags-loop-continue )
; defaults:
; M-\. : find-tag
; C-M-\. : find-tag-regexp

;; laptop keys?
(global-set-key [(XF86Forward)] 'next-buffer)
(global-set-key [(XF86Back   )] 'previous-buffer)
(global-set-key [(XF86AudioNext)] 'next-buffer)
(global-set-key [(XF86AudioPrev)] 'previous-buffer)
(global-set-key [(XF86Search)] 'grep)

(defun kill-emacs-wishy-washy ()
  "ask before quiting"
  (interactive)
  (if (yes-or-no-p "Quit Now? " )
      (save-buffers-kill-emacs)
    (beep)))

(global-set-key [(control x)(control c)] 'kill-emacs-wishy-washy)

;;======================
(global-set-key [(f14)] 'undo )
(global-set-key [(f8)] 'grep)
(global-set-key [(f3)] '(lambda() (interactive) (make-frame-command)))
(global-set-key [(f4)] '(lambda() (interactive) (load "~/.emacs" )))
(global-set-key [(f5)] 'set-background-color)

(column-number-mode t)
(line-number-mode t)
(global-set-key [(meta \*)] 'pop-tag-mark)

; =========== ;
; other defaults ;
; =========== ;

(require 'font-lock)
(global-font-lock-mode t)
;(setq font-lock-support-mode 'lazy-lock-mode) default (just in time) works great now
(setq font-lock-maximum-decoration t)

;(setq-default visible-bell t)                             ;; Don't make noise
(setq-default delete-auto-save-files t)                   ;; Delete auto-save file when a buffer killed
(setq-default track-eol t)                                ;; Don't follow the EOL
(setq-default truncate-lines t)                           ;; Don't wrap long lines (auto-show is helpful..)
(setq-default default-major-mode (quote text-mode))       ;; Default to text mode for unknown extensions
; (setq-default auto-raise-tool-bar-buttons nil)
(setq-default comment-empty-lines 'eol)

(require 'paren)                                          ;; Automatic parenthesis hilighting
(setq-default fill-column 75)                             ;; Wrap (if allowed) at column 75
(setq-default indent-tabs-mode nil)                       ;; No Hard tabs in our code
(setq-default show-trailing-whitespace t)                 ;; show it
(setq-default search-highlight t)                         ;; Highlight found text in incremental search

(setq-default comint-scroll-show-maximum-output t)        ;; Max scroll in shell
(setq-default comint-scroll-to-bottom-on-input t)         ;; Scroll shell window to bottom on paste/input
(setq-default comint-scroll-to-bottom-on-output t) ;; 'this)    ;; Scroll shell window to bottom on output
(setq-default query-replace-highlight t)                  ;; highlight words during query replacement
(setq-default next-line-add-newlines nil)                 ;; down arrow doesnt insert new lines
(setq-default electric-indent-mode nil)                   ;; control J should indent, return should not

(setq-default ediff-window-setup-function 'ediff-setup-windows-plain) ;; no multiframe, thank you

(setq auto-mode-alist (append '(
;;                                ("\\.log$"  . compilation-mode)
                                ("\\.log$"  . log-view-mode   )
                                ("\\.pod$"  . cperl-mode      )
                                ("\\.yp$"   . cperl-mode      )
;;                                 ("\\.swus$" . cperl-mode      )
                                ("\\.t$"    . cperl-mode      )
;;                                 ("\\.hs$"   . asm-mode        )
                                ("\\.hs$"   . haskell-mode    )
                                ("\\.ppcs$" . asm-mode        )
                                ("\\.ith$"  . tcl-mode        )
                                ("\\.itb$"  . tcl-mode        ) 
;;                                 ("^/etc/"   . sh-mode         )
                                ("\\.conf"  . conf-mode       )
                                ("\\.xs$"   . c-mode          )
                                ("\\.php$"  . html-mode       )
                                ("\\.m$"    . octave-mode     )
                                ("\\.py$"   . python-mode     )
                                ("\\.jinja"  . python-mode  )
                                ("SConscript$" . python-mode  )
                                ("\\.json$" . javascript-mode )
                                ("bashrc"   . shell-script-mode)
                                ("\\.cnfg$" . ruby-mode       )
                                ) auto-mode-alist))


(setq frame-title-format (concat
			  "%b ["
			  user-login-name
			  " "
			  system-name
                          "] %f"))                        ;; Make window title name of active buffer

(setq message-log-max nil)                                ;; Don't make message log entries
(setq inhibit-startup-message t)                          ;; Don't need to see that any more
(setq compilation-scroll-output t)                        ;; show me the errors
(fset 'yes-or-no-p 'y-or-n-p)                             ;; I'm sooo lazy 

;; (setq-default gud-gdb-command-name "gdb --annotate=3 -q ") ;; quiet

;; ==============
;; my path
;; ==============
(add-to-list 'load-path "~/.emacslisp")

;; ;; ===============
;; ;; python
;; ;; ===============
;; (if (require 'python-mode "/home/jezra/.emacslisp/python-mode.el" t)
;;     ()
;;   (message "can't find jezra's python-mode. So be it .." )
;;   )


; ================
; cperl 
; ================
(require 'cperl-mode)
(setq-default cperl-indent-level 4)
(setq-default cperl-merge-trailing-else nil)
(defalias 'perl-mode 'cperl-mode)

;; ===============
;; haskell
;; ===============

;; (if (require 'haskell-mode "/home/jezra/.emacslisp/haskell-mode.el" t)
;;     (load "/home/jezra/.emacslisp/haskell-font-lock.el")
;;   (message "can't find jezra's haskell-mode. ingnoring haskell ..")
;;   )

;; (if (require 'haskell-mode) 
;;   ()
;;   (message "can't find haskell-mode")
;;   ;; more ?
;;   )


; ================
; colors
; ================
(require 'faces)

(defun je-light-colors () (interactive)
  (set-face-background 'region "light steel blue")
  ;; (set-face-background 'modeline "blue4")  <- "modeline" is older version, breaks at 24.x
  ;; (set-face-foreground 'modeline "white")
  (set-face-background 'mode-line "blue4")
  (set-face-foreground 'mode-line "white")
  (set-face-background 'mode-line-inactive "blue4")
  (set-face-foreground 'mode-line-inactive "grey80")
  (if (eq user-login-name "root")
      (set-face-background 'default "LightCyan")
    (set-face-background 'default "grey85"))
  (set-face-foreground 'default  "black")
  (set-face-foreground 'font-lock-string-face "green4" )
  (set-face-foreground 'font-lock-comment-face "red3")
 ;; (set-face-foreground 'font-lock-comment-face "aquamarine4")
  (set-face-foreground 'minibuffer-prompt "DarkBlue")
  (set-face-background 'minibuffer-prompt "Yellow3")
  (set-face-background 'trailing-whitespace "grey50")
  )
(defun je-dark-colors () (interactive)
  (if (eq user-login-name "root")
      (set-face-background 'default "LightCyan")
    (set-face-background 'default "black"))
  (set-face-background 'region "grey60")
  (set-face-background 'mode-line "grey50")
  (set-face-foreground 'mode-line "LightCyan")
  (set-face-background 'mode-line-inactive "grey50")
  (set-face-foreground 'mode-line-inactive "grey85")
  (set-face-foreground 'default  "white")
  (set-face-foreground 'font-lock-string-face "green3" )
   (set-face-foreground 'font-lock-comment-face "pink3")
  ;; (set-face-foreground 'font-lock-comment-face "aquamarine4")
  (set-face-foreground 'minibuffer-prompt "DarkBlue")
  (set-face-background 'minibuffer-prompt "Yellow3")
  (set-face-background 'cursor "cyan")
  (set-face-background 'trailing-whitespace "grey50")
       ;; (set-face-foreground 'minibuffer-prompt "black")))
  )
(defun je-term-colors () (interactive)
  (set-face-background 'default "black")
  (set-face-background 'region "green")
  (set-face-background 'mode-line "white")
  (set-face-foreground 'mode-line "black")
  (set-face-background 'mode-line-inactive "black")
  (set-face-foreground 'mode-line-inactive "white")
  (set-face-foreground 'default  "white")
  (set-face-foreground 'font-lock-string-face "green" )
  (set-face-foreground 'font-lock-comment-face "magenta")
  (set-face-foreground 'minibuffer-prompt "white")
  (set-face-background 'minibuffer-prompt "black")
       ;; (set-face-foreground 'minibuffer-prompt "black")))
  ;; (cond ((facep 'show-paren-match-face)
  ;;        (set-face-background 'show-paren-match-face "magenta")
  ;;        (set-face-foreground 'show-paren-match-face "white"))
  ;;       (let ()
  ;;         (set-face-background 'highlight "magenta")
  ;;         (set-face-foreground 'highlight "white")))
  )

;; (cond ((facep 'show-paren-match-face)
;;        (set-face-background 'show-paren-match-face "indian red")
;;        (set-face-foreground 'show-paren-match-face "white"))
;;       (let ()
;;        (set-face-background 'highlight "indian red")
;;        (set-face-foreground 'highlight "white")))

(if (eq window-system nil)
    (je-term-colors)
  (je-dark-colors))

;; (if (eq user-login-name "root")
;;     (run-with-idle-timer 1 nil 'set-background-color "LightCyan")
;;   (run-with-idle-timer 1 nil 'set-background-color "grey85"))


(transient-mark-mode 1)                  ; Show marked text

(show-paren-mode t)                      ; show it
(setq-default show-paren-style "parenthesis")

;; (require 'escreen)                      ;; virtual desktop style
;; ;;(global-set-key [(control \\)(i)] 'escreen-install)
;; (escreen-install)
;; ^== Instead use (C-x r f/w) to store frame/window in register (C-x r j) to restore

;; ======================
;; C style
;; ======================
(require 'diff-mode-)                   ;; colour your diffs 
(require 'switch-file)                  ;; toggle *.h(pp)? <=> *.c(pp)?
(require 'parenthesis)                  ;; closing parenthesis

(defun my-c-hook ()
  (global-set-key [(control c) (h)] 'switch-cc-to-h)

  (global-set-key
   [(control c) (o)]
   '(lambda (offset)
      (interactive "nc offset: ")
      (setq c-basic-offset offset)))

  (parenthesis-register-keys "{(\"[" c-mode-map)
  (parenthesis-register-keys "{(\"[" c++-mode-map)

  (setq c-basic-offset 4)
  (setq tab-width 4)

  ;; (message "my c++-mode-hook")
  ;;             (c-set-style "eclipse") ;; A desperate attempt to keep up with the mess
  ;; (c-set-style "k&r")
  ;; (if (string-match "/gdb-" buffer-file-name)
  ;;     (c-set-style "gnu")
    (if (or (string-match "/core-system" buffer-file-name)
            (string-match "/mf-core" buffer-file-name))
        (c-set-style "eclipse")
    (c-set-style "k&r"))
    )

(add-hook 'c-mode-hook 'my-c-hook)

(c-add-style "k&r"
             '("k&r",
               (c-basic-offset . 4)
               (c-offsets-alist
                (innamespace . [0]) ;; vector makes absolute indentation
                (namespace-open . 0)
                (namespace-close . 0)
                (case-label . +))))

(font-lock-add-keywords
 'c-mode
 '(("\\<\\(FIXME\\|je-TODO\\|TODO\\)" 1 font-lock-warning-face prepend)))

(font-lock-add-keywords
 'c++-mode
 '(("\\<\\(FIXME\\|je-TODO\\|TODO\\)" 1 font-lock-warning-face prepend)
   ("\\<\\(wrlock\\|rdlock\\|unlock\\)\\>" . font-lock-keyword-face)
   ("\\<\\(SER_STMP_\\w+\\)\\>" . font-lock-constant-face)
   ("nullptr" . font-lock-constant-face)
   ("override" . font-lock-keyword-face)
   ))

(add-hook 'c++-mode-hook `my-c-hook)

(defun icompile ()
  "Obsolete leftover..."
  (interactive)
  (let ()
    ;; (compile "/home/jezra/bin/x make")
    (compile compile-command)
    ))
;; (setq compile-command "x imake skip_version_check=true MF_PARALLEL=8 mfc") ; init value
;;(setq compile-command "~/bin/x imake core") ; init value

;; kill running compilation without asking
(add-hook
 'compilation-start-hook
 (lambda (process) (set-process-query-on-exit-flag process nil)) nil t)

(setq tab-width 4)

(defun c-add-func-name-suffix ()
  "Make Ido happy - add trailing func-name comment."
  (interactive)
  (backward-sexp 3)
  (setq func-name (symbol-name (symbol-at-point)))
  (forward-sexp 3)
  (insert " // ")
  (insert func-name) )

(global-set-key [(control \;) (control \;)] 'c-add-func-name-suffix)

;; new c style
(c-add-style "eclipse"                  ; Guessed Eclipse style
             '("gnu"
               (c-basic-offset . 4)     ; Guessed value (guessed wrong - jezra)
               (c-offsets-alist
                (arglist-cont . 0)      ; Guessed value
                (arglist-intro . 0)     ; Guessed value
                (block-close . 0)       ; Guessed value
                (case-label . +)        ; Guessed value
                (defun-block-intro . +) ; Guessed value
                (defun-close . 0)       ; Guessed value
                (defun-open . 0)        ; Guessed value
                (else-clause . 0)       ; Guessed value
                (innamespace . 0)       ; Guessed value
                (label . 0)             ; Guessed value
                (member-init-intro . +) ; Guessed value
                (namespace-close . 0)   ; Guessed value
                (statement . 0)         ; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-open . 0) ; Guessed value
                (statement-cont . +)    ; Guessed value
                (substatement . +)      ; Guessed value
                (substatement-open . 0) ; Guessed value
                (topmost-intro . 0)     ; Guessed value
                (topmost-intro-cont . 0) ; Guessed value
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont-nonempty . c-lineup-arglist)
                (block-open . 0)
                (brace-entry-open . 0)
                (brace-list-close . 0)
                (brace-list-entry . 0)
                (brace-list-intro . +)
                (brace-list-open . +)
                (c . c-lineup-C-comments)
                (catch-clause . 0)
                (class-close . 0)
                (class-open . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . +)
                (do-while-closure . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . +)
                (inclass . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . +)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (module-close . 0)
                (module-open . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-intro . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement-label . 0)
                (template-args-cont c-lineup-template-args +))))

;; ======================
;; some special keys (prefix by control ;)
;; ======================
(require 'shell)
(global-set-key [(control \;) ( f  )] 'comint-dynamic-complete-filename)
(global-set-key [(control \;) ( \\ )] 'c-backslash-region)
(global-set-key [(control \;) (control r)] 'revert-buffer)
(global-set-key [(control \;) ( c  )] 'compile)
(global-set-key [(control \;) ( n  )] 'normal-mode)
(global-set-key [(control \;) ( v  )] 'visual-line-mode)
(global-set-key [(f6)] 'next-error)
(global-set-key [(control \;) ( meta \; )] 'comment-box)

(global-set-key [(control \;) ( m )] 'icompile)
(global-set-key [(control \;) ( i )] 'imenu-add-menubar-index )
(global-set-key [(control \;) ( w )] '(lambda ()
                                        (interactive)
                                        (which-func-mode)
                                        (set-face-foreground 'which-func "orange")))

(global-set-key[(control \;) ( G )] 'gdb)
(global-set-key[(control \;) ( B )] 'gud-tbreak)
(global-set-key[(control \;) ( C )] 'gud-cont)

;; (add-hook 'asm-mode-hook '(lambda () 
;;                             (define-key asm-mode-map "\C-m" 'newline) 
;;                             ))
;; (setq-default asm-comment-char 124)     ;; consider '|' as a comment

(global-set-key [(control \;) ( t )] '(lambda (width)
                                        (interactive "ntab width: ")
                                        (setq tab-width width)))
(global-set-key [(control \;) ( l )] 'c-set-style)
(global-set-key [(control \;) ( a )] 'global-auto-revert-mode)
(global-set-key [(control \;) (\% )] 'tags-query-replace)
(global-set-key [(control \;) ( s )] 'speedbar)

;; ;; ============================================
;; ;; squat commands : sticky direcotry
;; ;; ============================================

;; (defvar squat-dir-default "~/symm")
;; (defun  squat-dir-hook ()
;;   (setq default-directory squat-dir-default))
;; (defun  squat-dir (dir)
;;   "set fixed default directory for every newly opened file."
;;   (interactive "DSquat Dir: ")
;;   (if (> (length dir) 0) (setq squat-dir-default dir))
;;   (add-hook 'find-file-hooks 'squat-dir-hook )
;;   (message (concat "Squat mode in " squat-dir-default)))
;; (defun squat-dir-release ()
;;   (interactive)
;;   (remove-hook 'find-file-hooks 'squat-dir-hook)
;;   (message "Squat mode released "))
;; (global-set-key [(control \;) ( s  )] 'squat-dir )
;; (global-set-key [(control \;) ( S  )] 'squat-dir-release )

;; ===========
;; Set ifind mode
;; ===========

(defun squat-ifind-dir (dir)
  "set base dir for ifind"
  (interactive "DSquat Dir: ")
  (defvar workspace-dir dir)
  (load "ifind-mode.el")
  (setq ifind-dir dir)                  ;allow double dipping
  ;; (add-to-list ifind-excluded-dirs "build" "mgmt2") - rats - they are using a plain string
  (if (not (string-match "mgmt2" ifind-excluded-dirs))
      (setq ifind-excluded-dirs (concat ifind-excluded-dirs " -o -path \\*/build -o -path \\*/mgmt2 -o -path \\*/Attic")))
  )

(global-set-key [(control \;)( control d )] 'squat-ifind-dir)
(global-set-key [(control \;)( control f )] 'ifind-mode)
;;(setq ifind-command "~/bin/x ls_eif %s %s %s")
(setq ifind-command "/usr/bin/perl -e 'sub {my ($dir, @all) = @_ ;chdir $dir ;$dir .= q{/} unless $dir =~ m{/$};my $reg = pop @all;my $cwd = git_root ;$cwd =~ s{/*$}{/} ;my $re = qr{$reg} ;return print map {$dir.$_ } grep /$re/, qx/git ls/ if $reg =~ m{/} ; print map {qq{$dir/$_} } grep {my ($a) = m{([^/]+)\n} ; $a =~ $re} qx/git ls/; }->(@ARGV)' %s %s %s"
)

; ======================
;; Fix a bug fix in perl's debugger
;; ======================
(defun gud-perldb-massage-args (file args)
  (cond ((equal (car args) "-dx")
         (cons "-dx"
               (cons (car args)
                     (cons (nth 1 args)
                           (cons "-emacs" (cdr (cdr args)))))))

         ((equal (car args) "-e")
          (cons "-d"
                (cons (car args)
                      (cons (nth 1 args)
                            (cons "--" (cons "-emacs" (cdr (cdr args))))))))
         (t
          (cons "-d" (cons (car args) (cons "-emacs" (cdr args)))))))

; (defun gud-perldb-massage-args (file args)
;   (cond ((equal (car args) "-e")
; 	 (cons "-d"
; 	       (cons (car args)
; 		     (cons (nth 1 args)
; 			   (cons "--" (cons "-emacs" (cdr (cdr args))))))))
; 	(t
; 	 (cons "-d" (cons (car args) (cons "-emacs" (cdr args)))))))

;; (setq-default cperl-hash-face
;; ' ( ((((class color) (background light)) 
;;       (:foreground "Red" :background "lightyellow2" :bold t))
;;      (((class color) (background dark)) 
;;       (:foreground "Red" :background "lightblue" :bold t :italic t))
;;      (((class grayscale) (background light))
;;       (:background "Gray90" :bold t :italic t))
;;      (((class grayscale) (background dark))
;;       (:foreground "Gray80" :bold t :italic t))
;;      (t (:bold t :italic t)))))
;; (global-set-key [(control c)(control h)(D)] 'cperl-perldoc)
;; (global-set-key [(control c)(control h)(d)] 'cperl-perldoc-at-point)
;; (global-set-key [(control c)(control h)(P)] 'cperl-pod-to-manpage)

(global-set-key [(control c) (a)] 'align-regexp)

;; Avoid 'auto-customizing' in this file
(setq custom-file "~/.emacslisp/custom.el")
(load custom-file)

;; better duplicate buffer naming
(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward)


;; faster than default scp
(setq tramp-default-method "ssh")
(setq-default process-connection-type nil)

;; ========================
;; http: lynx like browsing
;; ========================

(defun www ()
  (interactive)
  (require 'w3)
  (w3))

;; Eliminate big chunks undo warnings.
;;(add-to-list 'warning-suppress-types '(undo discard-info))

(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; ====================
;; R&D
;; ====================
;; auto-complete: 
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacslisp/ac-dict")
;; (ac-config-default)


;; (defun force-other-window ()
;;   "If there is a second window visible, switch to it. If not, create a
;; second window, set it to some interesting buffer, and switch to the
;; new window"
;;   (interactive)
;;   (if (> (count-windows) 1)
;;       (other-window 1)
;;     (split-window-vertically)
;;     (other-window 1)
;;     (switch-to-buffer (other-buffer))))
;; 
;; (defun swap-windows ()
;;   "Swap the buffers displayed in the two current windows"
;;   (interactive)
;;   (if (> (count-windows) 1)
;;     (let (buf1 buf2)
;;       (setq buf1 (buffer-name))
;;       (other-window 1)
;;       (setq buf2 (buffer-name))
;;       (switch-to-buffer buf1)
;;       (other-window 1)
;;       (switch-to-buffer buf2)))
;;   (next-buffer))
;; 
;; ;; parole: 
;; (global-set-key [(control \;) (\.)] 'force-other-window)
;; (global-set-key [(control \;) (\')] 'swap-windows)

(global-set-key [(f7)             ] 'mode-line-other-buffer) ;quick toggle?

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; ====================
;; version 24 goodies
;; ====================

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; ;; after copy Ctrl+c in X11 apps, you can paste by `yank' in emacs
;; (setq x-select-enable-clipboard t)
;; ;; after mouse selection in X11, you can paste by `yank' in emacs
;; (setq x-select-enable-primary t)
  ;; (global-set-key [(control \;) (u)] 'auto-complete-mode)
  )


;; ======================
;; AUTOWRITE
;; ======================
(global-set-key [(control \;) (p)]      ; new perl script
                '(lambda()
                   (interactive)
                   (beginning-of-buffer)
                   (insert "# -*- cperl -*-

eval 'exec /usr/bin/perl $0 $*'
    if 0 ;

use 5.10.0 ;
use warnings ;
use strict ;
use integer ;
use bytes ;

" )
                   (cperl-mode)
                   ))

(global-set-key [(control \;) (b)]      ; new Shell::MultiCmd item
                '(lambda ()
                   (interactive)
                   (insert "{{
    help => qq/
/,
    opts => [],
    exec => sub {
        my ($o, %p) = @_ ;
    }}}")))


(defun infi-new-legal ()
  (interactive)
  (insert "
/******************************************************************************************************/
/*                                                                                                    */
/*       xxxxxx Ltd.  -  Proprietary and Confidential Material                                        */
/*                                                                                                    */
/*    Copyright (C) 2020, xxxxxx    Ltd. - All Rights Reserved                                        */
/*                                                                                                    */
/*    NOTICE: All information contained herein is, and remains the property of xxxxxxxxx Ltd.         */
/*    All information contained herein is protected by trade secret or copyright law.                 */
/*    The intellectual and technical concepts contained herein are proprietary to xxxxxxxxx Ltd.,     */
/*    and may be protected by U.S. and Foreign Patents, or patents in progress.                       */
/*                                                                                                    */
/*    Redistribution or use, in source or binary forms, with or without modification,                 */
/*    are strictly forbidden unless prior written permission is obtained from xxxxxxxxx Ltd.          */
/*                                                                                                    */
/*                                                                                                    */
/******************************************************************************************************/

") (end-of-buffer))

(defun infi-new-hpp()
  (interactive)
  (infi-new-legal)
  (insert "

#pragma once

#include \"whatever.hpp\"
namespace mfc {


}
"))

(defun infi-new-cpp ()
  (interactive)
  (infi-new-legal)
  (insert-string "

#include \".hpp\"
namespace mfc {
}
" ))


;; r n d : python electic
(defun electric-pair ()
  "If at end of line, insert character pair without surrounding spaces.
    Otherwise, just insert the typed character."
  (interactive)
  (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))

;; r n d :
;; highlight c #if 0 endif
;; (defun cpp-highlight-if-0/1 ()
;;   "Modify the face of text in between #if 0 ... #endif."
;;   (interactive)
;;   (setq cpp-known-face '(background-color . "gray10"))
;;   (setq cpp-unknown-face 'default)
;;   (setq cpp-face-type 'dark)
;;   (setq cpp-known-writable 't)
;;   (setq cpp-unknown-writable 't)
;;   (setq cpp-edit-list
;;         ;; There are SO many issues with this explicit coloring code. I should either erase it or
;;         ;; fix it ...
;;         '((#("1" 0 1
;;              (fontified nil))
;;            nil
;;            (background-color . "black")
;;            both nil)
;;           (#("0" 0 1
;;              (fontified nil))
;;            (background-color . "gray10")
;;            nil
;;            both nil)))
;;   (cpp-highlight-buffer t))
;; 
;; (defun jpk/c-mode-hook ()
;;   (cpp-highlight-if-0/1)
;;   (add-hook 'after-save-hook 'cpp-highlight-if-0/1 'append 'local)
;;   )
;; 
;; (add-hook 'c-mode-common-hook 'jpk/c-mode-hook)


(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))


;; ======================
;; DONE
;; ======================
(message ".emacs .. Done" )
