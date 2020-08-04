;; Author: Frank SHe
;; Co-Author: Fred Yu

;; Others configs which were put here due to overrides

    ;; pyim: set eng. punctuation

(setq pyim-punctuation-translate-p '(no yes auto))   ;使用半角标点。

;; -----


;; System setting

    ;; Default dir


;;(setq command-line-default-directory "~/your/path/")
(setq command-line-default-directory "~/Documents/Org/")


    ;; All Utf-8

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


    ;; External copy & paste

;; (setq x-select-enable-clipboard t)


;; UI related

    ;; Line numbers (Frank's config)

;;(global-linum-mode 1)
;;(setq linum-format "%d ")
;;(setq linum-format "%d| ")

;; (global-display-line-numbers-mode)
;; (setq display-line-numbers-width-start t)
;; (linum-mode)
;; (linum-relative-global-mode)


    ;; Highlight cursor line

(global-hl-line-mode t)


    ;; Disable cursor blink

(blink-cursor-mode -1)


    ;; Hide bars

(tool-bar-mode 0)
(menu-bar-mode 0)


    ;; Display time on status bar

(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


    ;; Display path on title bar

(setq frame-title-format "emacs@%b")


    ;; Disable warning

(setq visible-bell t)
(setq ring-bell-function 'ignore)


    ;; Abbreviation for yes and no

(fset 'yes-or-no-p 'y-or-n-p)


    ;; Enable flyspell

(add-hook 'org-mode-hook 'flyspell-prog-mode)


    ;; Convert tabs to spaces

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; (setq default-tab-width 4)


    ;; Font

;; (set-default-font "Microsoft YaHei Mono-10")


    ;; Transparency

;; (set-frame-parameter nil 'alpha '(85 . 100))


;; Temp files location

    ;; Auto save

(setq-default auto-save-timeout 15) ; 15秒无动作,自动保存
(setq-default auto-save-interval 200) ; 200个字符间隔, 自动保存


    ;; Auto backup

(setq
     backup-by-copying t ; 自动备份
     backup-directory-alist
     '(("." . "~/Documents/Backup")) ; 自动备份在目录"~/.em_backup"下
     delete-old-versions t ; 自动删除旧的备份文件
     kept-new-versions 3 ; 保留最近的3个备份文件
     kept-old-versions 1 ; 保留最早的1个备份文件
     version-control t) ; 多次备份

;; (setq backup-by-copying t) ;使用复制模式备份文件


    ;; Org mode export dir according to suffix

  (defvar org-export-output-directory-prefix "Export_" "prefix of directory used for org-mode export")

    (defadvice org-export-output-file-name (before org-add-export-dir activate)
      "Modifies org-export to place exported files in a different directory"
      (when (not pub-dir)
          (setq pub-dir (concat org-export-output-directory-prefix (substring extension 1)))
          (when (not (file-directory-p pub-dir))
           (make-directory pub-dir))))


;; -----


;; Org Agenda

    ;; Dir

(setq org-agenda-files (list "~/Documents/Org"))

    ;; Shortcut

(global-set-key (kbd "C-c a") 'org-agenda)

    ;; Tags

(setq org-tag-alist
      '(("Work" . ?w) ("Learn" . ?l) ("Sport" . ?s) ("Play" . ?p)
	))

;; -----


;; Org Capture

    ;; Dir default

(setq org-default-notes-file "~/Documents/Org/gtd.org")

    ;; Shortcut

(global-set-key (kbd "C-c c") 'org-capture)

    ;; Templates

(setq org-capture-templates
      '(("c" "Calendar" entry (file+headline "~/Documents/Org/calendar.org" "calendar")
         "* TODO %?\n  %i\n  %a")
        ("i" "Inbox" entry (file+datetree "~/Documents/Org/inbox.org")
         "* TODO %?\nEntered on %U\n  %i\n  %a")))

;; -----


;; Package mgr

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers (quote visual))
 '(org-ascii-global-margin0 nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-html-head "<style type=\"text/css\">body{margin:100px}</style>")
 '(package-selected-packages
   (quote
    (markdown-mode yasnippet posframe pyim winum elfeed-org elfeed org-brain helm magit plantuml-mode company evil-escape emms htmlize org-pomodoro ox-reveal evil monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -----


;; Package mgt

    ;; Monokai

(load-theme 'monokai t)


    ;; evil

(add-to-list 'load-path "~/.emacs.d/evil")

(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)


    ;; evil-escape

(add-hook 'org-mode-hook 'evil-escape-mode)

(require 'evil-escape)
(setq-default evil-escape-key-sequence "jk")
;; (setq-default evil-escape-key-sequence "kj")
(setq-default evil-escape-delay 0.2)


    ;; helm

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)


    ;; company

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


    ;; yasnippet

(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/Documents/Org"                 ;; personal snippets
      ;; '("~/.emacs.d/snippets"                 ;; personal snippets
        ;; "/path/to/some/collection/"           ;; foo-mode and bar-mode snippet collection
        ;; "/path/to/yasnippet/yasmate/snippets" ;; the yasmate collection
        ))

(yas-global-mode 1) ;; or m-x yas-reload-all if you've started yasnippet already.

    ;; use yasnippet in org mode code block

;; (setq org-src-fontify-natively t)
;; (setq org-src-tab-acts-natively t)

;; (defun my-org-mode-hook ()
;;   (setq-local yas-buffer-local-condition
;;               '(not (org-in-src-block-p t))))
;; (add-hook 'org-mode-hook #'my-org-mode-hook)


    ;; reveal.js

(require 'ox-reveal)
(setq Org-Reveal-root "~/reveal.js-3.8.0")
(setq Org-Reveal-title-slide nil)


    ;; emms

(add-to-list 'load-path "~/elisp/emms/")
        (require 'emms-setup)
        (emms-standard)
        (emms-default-players)
        (setq emms-source-file-default-directory "~/Music/")


    ;; plantuml-mode

;; active Org-babel languages
(org-babel-do-load-languages
    'org-babel-load-languages
      '(;; other Babel languages
	   (python . t)
	   (latex . t)
       (lisp . t)
           (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/plantuml.jar"))

;; Attempt to solve import error of python packages in org mode (Frank's config)
(setq python-shell-interpreter "python3")

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

;; Integration with org-mode
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))


    ;; org-brain

(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/Documents/Org")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))


    ;; winum

(setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "C-`") 'winum-select-window-by-number)
      (define-key map (kbd "C-²") 'winum-select-window-by-number)
      (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
      (define-key map (kbd "M-1") 'winum-select-window-1)
      (define-key map (kbd "M-2") 'winum-select-window-2)
      (define-key map (kbd "M-3") 'winum-select-window-3)
      (define-key map (kbd "M-4") 'winum-select-window-4)
      (define-key map (kbd "M-5") 'winum-select-window-5)
      (define-key map (kbd "M-6") 'winum-select-window-6)
      (define-key map (kbd "M-7") 'winum-select-window-7)
      (define-key map (kbd "M-8") 'winum-select-window-8)
      map))

(require 'winum)

(winum-mode)


    ;; elfeed

;; (global-set-key (kbd "C-x w") 'elfeed)

;; (setq elfeed-feeds
;;       '("http://36kr.com/feed"
;;         "http://blog.yinxiang.com/feed/"))

;; (setq elfeed-feeds
;;       '("http://www.reddit.com/r/emacs/.rss"
;; 	"http://www.hup.harvard.edu/hup_rss.php?new=n"
;;         "http://pragmaticemacs.com/feed/"))

;; (setf url-queue-timeout 30)


    ;; pyim

(use-package pyim
  :ensure nil
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")

  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  ;; (setq-default pyim-english-input-switch-functions
  ;;               '(pyim-probe-dynamic-english
  ;;                 pyim-probe-isearch-mode
  ;;                 pyim-probe-program-mode
  ;;                 pyim-probe-org-structure-template))

  ;; (setq-default pyim-punctuation-half-width-functions
  ;;               '(pyim-probe-punctuation-line-beginning
  ;;                 pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  ;; (setq pyim-page-tooltip 'popup)
  (setq pyim-page-tooltip 'posframe)

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  :bind
   (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))

;; Highlight latex text in org mode (Frank's config)
(setq org-highlight-latex-and-related ' (latex))

;; syntax highlight inserted code (Frank's config) 
(setq org-src-fontify-natively t)

;; auto-matching parenthesis (Frank's config)   
(electric-pair-mode t)
(show-paren-mode t)

(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\$ . ?\$)
        (?\{ . ?\})
        ))


;; org mode latex preview (Frank's config)
;; The first command is for earlier versions of org mode  
;;(setq org-latex-create-formula-image-program 'dvipng)
(setq org-preview-latex-default-process 'dvipng)

;; displaying relative line number as well as the absolute line number (Franks config)
;; (global-linum-mode t)
;; (linum-relative-global-mode t)
;; (setq-default display-inline-numbers 'relative')

;; setting the default browser as firefox (Frank's config)
(setq org-file-apps
    (quote 
	((auto-mode .emacs)
	("\\.mm\'" . default)
	("\\.x?html?\\'" . "/usr/bin/firefox %s")
	("\\.pdf\\'" . default))))

;; using latex packages in org mode (Frank's config)
(require 'ox-latex)

;; (setq org-latex-listings t)
;; (add-to-list 'org-latex-packages-alist '("" "listings"))
;; (add-to-list 'org-latex-packages-alist '("" "color"))
;; (add-to-list 'org-latex-package-alist '("" "footnote"))

;; Setting color for the 'consolidation' tag (Frank's config)
;; not working at the moment
(require 'org)
(setq org-tag-persistent-alist 
      '((:startgroup . nil)
        ("CONSOLIDATION" . ?c) 
        (:endgroup . nil)
        )
)

(setq org-tag-faces
      '(
        ("CONSOLIDATION" . (:foreground "red" :weight bold))
        )
)     


;; Org file export as Markdown (Frank's config)
;; (with-eval-after-load 'org
;; (add-to-list 'org-export-backends 'md))

;; Emacs Markdown-mode (Frank's config)
;; (require 'package)
;; (add-to-list 'package-archives
;;            '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; (package-initialize)

;; JEDI python auto complete (Frank's config)
(add-hook 'python-mode-hook 'jedi:setup)
; (setq jedi:complete-on-dot t)                 ; optional


;; -----
;; Others configs which were put here due to overrides

;; Org Mode

    ;; Activate easy templates

(require 'org-tempo)

;; ------

