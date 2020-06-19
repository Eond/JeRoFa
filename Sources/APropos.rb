# About.rb
########################################
# Par Jean-Fran�ois Brun
# En date du 29 Avril 2011
########################################
# Historique
# ----------
#
# 2011.04.15 Jean-Fran�ois Brun
# 	Cr�ation de la classe 'About'.
#2011.04.29 Jean-Fran�ois Brun
#	Mise en place de la fen�tre
# --------------------------------------------------------------
# 	About
# --------------------------------------------------------------
# Fen�tre du About

class AboutWindow < TkToplevel
	def initialize(*args)
		super
		protocol('WM_DELETE_WINDOW', proc{toggleAbout(true)})
		geometry('550x300')
		resizable(false, false)
		#setIcon(-file => 'img\DOT.ico')
		#verrideredirect(true) -- place l'application en fullscreen
	end 
end

$GameAbout = AboutWindow.new($GameWindow) {
	title 'D&D Online Tabletop - About'
}

def toggleAbout(force = nil)
	
	if $AboutHidden == nil
		$AboutHidden = true
	end
	
	if !(force==nil)
		$AboutHidden = !force
	else
		force = !$AboutHidden
	end
	
	if $AboutHidden
		logging 'SHOWING ABOUT'
		$GameAbout.deiconify
	else
		logging 'HIDDING ABOUT'
		$GameAbout.withdraw
	end
	
	$AboutHidden = force
end

toggleAbout(false)
toggleAbout(true)