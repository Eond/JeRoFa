# Manuel.rb
########################################
# Par Jean-Michel Beauvais
# En date du 16 Mars 2011
########################################
# Historique
# ----------
#
# 2011.04.05 - Jean-Michel Beauvais
# 	Création de la classe 'ManualWindow'.

# --------------------------------------------------------------
# Manual Window
# --------------------------------------------------------------
# Fenêtre du manuel.

MANUAL_ACCUEIL = 300
MANUAL_TEST    = 399

class ManualWindow < TkToplevel
	def initialize(*args)
		super
		protocol('WM_DELETE_WINDOW', proc{toggleManual(true)})
		geometry('100x50')
		resizable(false, false)
		#setIcon(-file => 'img\DOT.ico')
	end
end

$GameManual = ManualWindow.new($GameWindow) {
	title 'D&D Online Tabletop - Manual'
}

def toggleManual(force = nil)
	
	if $ManualHidden == nil
		$ManualHidden = true
	end
	
	if !(force==nil)
		$ManualHidden = !force
	else
		force = !$ManualHidden
	end
	
	if $ManualHidden
		logging 'SHOWING MANUAL'
		$GameManual.deiconify
	else
		logging 'HIDDING MANUAL'
		$GameManual.withdraw
	end
	
	$ManualHidden = force
end

#testManual = TkLabel.new($GameManual) {
#	text 'Test Manual'
#}

#testManual.pack('side'=>'bottom', 'anchor'=>'w')
toggleManual(false)
toggleManual(true)