((autopair status "installed" recipe
	   (:name autopair :website "https://github.com/capitaomorte/autopair" :description "Autopair is an extension to the Emacs text editor that automatically pairs braces and quotes." :type github :pkgname "capitaomorte/autopair" :features autopair))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-ir-black status "installed" recipe
		       (:name color-theme-ir-black :description "IR Black Color Theme for Emacs." :type github :pkgname "burke/color-theme-ir-black" :depends color-theme :prepare
			      (autoload 'color-theme-ir-black "color-theme-ir-black" "color-theme: ir-black" t)))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (enh-ruby-mode status "installed" recipe
		(:name enh-ruby-mode :description "Replacement for ruby-mode which uses ruby 1.9's Ripper to parse and indent. From Zenspider's repository." :type github :pkgname "zenspider/enhanced-ruby-mode" :prepare
		       (progn
			 (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
			 (add-to-list 'interpreter-mode-alist
				      '("ruby" . enh-ruby-mode))
			 (add-to-list 'auto-mode-alist
				      '("\\.rake$" . enh-ruby-mode))
			 (add-to-list 'auto-mode-alist
				      '("Rakefile$" . enh-ruby-mode))
			 (add-to-list 'auto-mode-alist
				      '("\\.gemspec$" . enh-ruby-mode))
			 (add-to-list 'auto-mode-alist
				      '("Gemfile$" . enh-ruby-mode))
			 (add-to-list 'auto-mode-alist
				      '("\\.rb$" . enh-ruby-mode)))))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (exec-path-from-shell status "installed" recipe
		       (:name exec-path-from-shell :website "https://github.com/purcell/exec-path-from-shell" :description "Emacs plugin for dynamic PATH loading" :type github :pkgname "purcell/exec-path-from-shell"))
 (helm status "installed" recipe
       (:name helm :description "Emacs incremental completion and narrowing framework" :type github :pkgname "emacs-helm/helm" :autoloads "helm-autoloads" :build
	      (("make"))
	      :build/darwin
	      `(("make" ,(format "EMACS_COMMAND=%s" el-get-emacs)))
	      :build/windows-nt
	      (let
		  ((generated-autoload-file
		    (expand-file-name "helm-autoloads.el"))
		   \
		   (backup-inhibited t))
	      (update-directory-autoloads default-directory)
	      nil)
       :features "helm-config" :post-init
       (helm-mode)))
(paredit status "installed" recipe
(:name paredit :description "Minor mode for editing parentheses" :type github :prepare
(progn
(autoload 'enable-paredit-mode "paredit")
(autoload 'disable-paredit-mode "paredit"))
:pkgname "emacsmirror/paredit"))
(pkg-info status "installed" recipe
(:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
(dash epl)))
(projectile status "installed" recipe
(:name projectile :description "Project navigation and management library for Emacs." :type github :pkgname "bbatsov/projectile" :depends pkg-info))
(smartparens status "installed" recipe
(:name smartparens :description "Autoinsert pairs of defined brackets and wrap regions" :type github :pkgname "Fuco1/smartparens" :depends dash))
(tomorrow-night-paradise-theme status "installed" recipe
(:name tomorrow-night-paradise-theme :description "A light-on-dark Emacs theme which is essentially a tweaked version of Chris Kempson's Tomorrow Night Bright theme." :website "https://github.com/jimeh/tomorrow-night-paradise-theme.el" :type github :pkgname "jimeh/tomorrow-night-paradise-theme.el" :minimum-emacs-version 24 :prepare
(add-to-list 'custom-theme-load-path default-directory)))
(tomorrow-theme status "installed" recipe
(:name tomorrow-theme :description "Colour Schemes for Hackers" :website "https://github.com/chriskempson/tomorrow-theme" :type github :pkgname "chriskempson/tomorrow-theme" :load-path "GNU Emacs" :minimum-emacs-version 24 :autoloads nil :post-init
(add-to-list 'custom-theme-load-path
(expand-file-name "GNU Emacs" default-directory))))
(twilight-anti-bright-theme status "installed" recipe
(:name twilight-anti-bright-theme :description "A light-on-dark Emacs theme inspired by the dark-on-light Twilight Bright TextMate theme." :website "https://github.com/jimeh/twilight-anti-bright-theme" :type github :pkgname "jimeh/twilight-anti-bright-theme" :minimum-emacs-version 24 :prepare
(add-to-list 'custom-theme-load-path default-directory)))
(web-mode status "installed" recipe
(:name web-mode :description "emacs major mode for editing PHP/JSP/ASP HTML templates (with embedded CSS and JS blocks)" :type github :pkgname "fxbois/web-mode")))
