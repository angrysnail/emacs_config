(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("/" "/"))))
 '(line-spacing 0.1)
 '(safe-local-variable-values (quote ((ffip-project-root . "~/.emacs.d/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;-----------------------------------------------------
;;一些通用的设置
;;-----------------------------------------------------
(global-linum-mode 1)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives
	       '("elpa" . "http://tromey.com/elpa/") t)
  (add-to-list 'package-archives 
	       '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

;;------------------------------------------------------
;;find-file-in-project   ffip-create-project-file
;;------------------------------------------------------
(autoload 'find-file-in-project "find-file-in-project" nil t)
(autoload 'find-file-in-project-by-selected "find-file-in-project" nil t)
(autoload 'find-directory-in-project-by-selected "find-file-in-project" nil t)
(autoload 'ffip-show-diff "find-file-in-project" nil t)
(autoload 'ffip-save-ivy-last "find-file-in-project" nil t)
(autoload 'ffip-ivy-resume "find-file-in-project" nil t)
(global-set-key (kbd "C-c f p") 'find-file-in-project)
(global-set-key (kbd "C-c f c") 'find-file-in-current-directory)
;;-----------------------------------------------------
;;Automatically turns on cscope-minor-mode when editing C and C++ sources
;;-----------------------------------------------------
(cscope-setup)
;;-----------------------------------------------------
;;ECB的配置
;;-----------------------------------------------------
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
;;-----------------------------------------------------
;;CEDET配置
;;-----------------------------------------------------
;; Enable the Project management system
(global-ede-mode 1)
;; Enable prototype help and smart completion 
;;(semantic-load-enable-code-helpers)      
;;(global-srecode-minor-mode 1)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;;TAB页显示
(require 'tabbar)
(tabbar-mode)
(global-set-key (kbd "<C-prior>")   'tabbar-backward)
(global-set-key (kbd "<C-next>")    'tabbar-forward)
;;表格工具
(autoload 'table-insert "table" "WYGIWYS table editor")
;;-----------------------------------------------------
;;最近打开的文件列表
;;-----------------------------------------------------
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
;;-----------------------------------------------------
;;ELPY的配置
;;-----------------------------------------------------
(elpy-enable)
;;-----------------------------------------------------
(require 'yasnippet)
(yas-global-mode 1)
;;-----------------------------------------------------
;;插入当前时间
(defun insertdate ()
  (interactive)
  (insert (format-time-string "\n* ~~~~~~~~~~~~~~~~~~~~~~~~ %Y-%m-%d , 星期%a ~~~~~~~~~~~~~~~~~~~~~ * \n")))
(global-set-key (kbd "C-c i d") 'insertdate)
;;取消备份文件 ~
(setq make-backup-files nil)
;;高亮显示当前的对象
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
