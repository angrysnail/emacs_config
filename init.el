;;; package --- Summary
;;; zcy
;;; Commentary:
;;; package:zcy
(custom-set-variables
 '(custom-enabled-themes (quote (tango-dark)))
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("/" "/"))))
 '(line-spacing 0.1)
 '(safe-local-variable-values (quote ((ffip-project-root . "~/.emacs.d/")))))
(custom-set-faces

)
;;===================================================
;; A. 一些通用的设置
;;===================================================
(global-linum-mode 1)
;;启动c+x c+u进行大小写变换
(put 'upcase-region 'disabled nil)
(when (>= emacs-major-version 24)
  (require 'package)
  ;;(add-to-list 'package-archives
  ;;         '("melpa" . "http://melpa.org/packages/") t)
  ;;(add-to-list 'package-archives
  ;;         '("elpa" . "http://tromey.com/elpa/") t)
  ;;(add-to-list 'package-archives 
  ;;         '("marmalade" . "http://marmalade-repo.org/packages/") t)
  ;;(add-to-list 'package-archives
  ;;           '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;;(add-to-list 'package-archives 
  ;;	       '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
  (setq package-archives
		'(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
		  ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
		  ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
		  ("melpa-stable" . "https://stable.melpa.org/packages/")))
  (package-initialize))
;-->>必须放在package设置的后面，否则说找不到，说明之后才有load-path<<--
(require 'flycheck)
(global-flycheck-mode)
;;-->>打开文件时自动列出文件列表<<--
(ido-mode t)
;-->>取消备份文件即~文件<<--
(setq make-backup-files nil)
;;===================================================
;; B. find-file-in-project   ffip-create-project-file
;;===================================================
(autoload 'find-file-in-project "find-file-in-project" nil t)
(autoload 'find-file-in-project-by-selected "find-file-in-project" nil t)
(autoload 'find-directory-in-project-by-selected "find-file-in-project" nil t)
(autoload 'ffip-show-diff "find-file-in-project" nil t)
(autoload 'ffip-save-ivy-last "find-file-in-project" nil t)
(autoload 'ffip-ivy-resume "find-file-in-project" nil t)
(global-set-key (kbd "C-c f p") 'find-file-in-project)
(global-set-key (kbd "C-c f c") 'find-file-in-current-directory)

;;===================================================
;; C. Automatically turns on cscope-minor-mode when editing C and C++ sources
;;===================================================
(cscope-setup)

;;===================================================
;; D. ECB的配置
;;===================================================
;;自动启动ECB
;;(require 'ecb)
;;并且不显示每日提示
(setq ecb-auto-activate t  ecb-tip-of-the-day nil)
;;;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
;;;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)
;;;; 使某一ecb窗口最大化
(global-set-key (kbd "C-c 1") 'ecb-maximize-window-directories)
(global-set-key (kbd "C-c 2") 'ecb-maximize-window-sources)
(global-set-key (kbd "C-c 3") 'ecb-maximize-window-methods)
(global-set-key (kbd "C-c 4") 'ecb-maximize-window-history)
;;;; 恢复原始窗口布局
(global-set-key (kbd "C-c 0") 'ecb-restore-default-window-sizes)
;;=====================================================
;; E. CEDET配置
;;=====================================================
;; Enable the Project management system
(global-ede-mode 1)
;; Enable prototype help and smart completion 
;;(semantic-load-enable-code-helpers)      
;;(global-srecode-minor-mode 1)

;;=====================================================
;; F. 用ibuffer来替换原来的buffer选择框
;;=====================================================
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;=====================================================
;; G. 列出所有的kill ring中的东西
;;=====================================================
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;;=====================================================
;; H. TAB页显示，但在ssh时可能不能用
;;=====================================================
(require 'tabbar)
(tabbar-mode)
(global-set-key (kbd "<C-prior>")   'tabbar-backward)
(global-set-key (kbd "<C-next>")    'tabbar-forward)
;;=====================================================
;; I. 表格工具及org工具的配置
;;=====================================================
(autoload 'table-insert "table" "WYGIWYS table editor")
;;-->>插入当前时间<<--
(defun insertdate ()
  (interactive)
  (insert (format-time-string "\n* ~~~~~~~~~~~~~~~~~~~~~~~~ %Y-%m-%d , 星期%a ~~~~~~~~~~~~~~~~~~~~~ * \n")))
(global-set-key (kbd "C-c i d") 'insertdate)
;;=====================================================
;; J. 最近打开的文件列表
;;=====================================================
(require 'recentf)
(recentf-mode 1)
(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
	 (tocpl (mapcar (function 
			 (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
	 (prompt (append '("File name: ") tocpl))
	 (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    (find-file (cdr (assoc-ignore-representation fname tocpl))))) 
(global-set-key [(control c)(control r)] 'recentf-open-files-compl)

;;=====================================================
;; K. 主要是用来对python进行配置
;;=====================================================
(elpy-enable)
;;=====================================================
;; L. 主要用于代码的片段快速录入
;;=====================================================
(require 'yasnippet)
(yas-global-mode 1)
;;=====================================================
;; M. 高亮显示当前的对象
;;=====================================================
(add-to-list 'load-path "~/.emacs.d/selfels/highlight-symbol.el-master")
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;;----------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/selfels/styleguide/")
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;=====================================================
;; N. 各种语言的配置，主要是mode的配置
;;=====================================================
;;可进行自定义的补全
(require 'auto-complete-config)
(auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;弹出选基后，进行上下选择的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;;风格缩进为4
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq default-tab-width  4)
(setq-default tab-width 4)

;;(set-default indent-tabs-mode nil)
;; 设置为t表示忽略大小写，设置为nil表示区分大小写
;; 默认情况下为smart，表示如果输入的字符串不含有大写字符才会忽略大小写
(setq ac-ignore-case t)
;;-->>yaml<<--
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
;;-->>go mode<<--
(add-to-list 'load-path "~/.emacs.d/selfels/go/")
(autoload 'go-mode "go-mode" nil t)
(autoload 'go-autocomplete "go-autocomplete" nil t)
(global-set-key (kbd "C-c C-d") 'godoc-at-point)
;;-->>go语言的自动联想设置，需执行下面的语句安装工具并设置一下<<--
;;go get -u github.com/nsf/gocode
;;gocode set propose-builtins true
(require 'go-autocomplete)

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))
;;保存文件的时候对该源文件做一下gofmt
(eval-after-load 'go-mode '(add-hook 'before-save-hook #'gofmt-before-save))



;;=====================================================
;; Z. 各种杂项的处理
;;=====================================================
;;-->>主要是为了secureCRT中回退键变成帮助键<<--
(global-set-key "\C-h" 'backward-delete-char-untabify)
;; (global-set-key "\d" 'delete-char)
