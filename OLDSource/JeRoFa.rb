# #######################################################################
# 
# Cette application est la propriété de Jean-François Brun, Jean-Michel Beauvais et du Cegep Saint-Jérôme en date du 18
# novembre 2010, dans le cadre du cours «Programmation Orientée Objet II», de la technique «Informatique de Gestion»
# 
# #######################################################################
# 
# Main.rb
# Initie les objets de départ de l'application.
# 
# #######################################################################

# Dimensions de la fenêtre
MAIN_MIN_WIDTH = 800
MAIN_MIN_HEIGHT = 600

require 'Qt4'

app = Qt::Application.new(ARGV)

require 'Interface/Widgets.rb'
require 'Interface/PopUps.rb'
require 'Interface/Fenetre.rb'
require 'Classes Fonctionnelles/SQL.rb'
require 'Classes Métiers/Manuel.rb'
#require 'Erreurs/GestionErreurs.rb'

iconLogo = Qt::Icon.new('img\LOGO\logo_16x.png')
	
app.setWindowIcon(iconLogo)

window = Fenetre.new()
window.resize(MAIN_MIN_WIDTH, MAIN_MIN_HEIGHT)
window.show()

app.exec()