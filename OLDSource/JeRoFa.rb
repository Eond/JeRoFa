# #######################################################################
# 
# Cette application est la propri�t� de Jean-Fran�ois Brun, Jean-Michel Beauvais et du Cegep Saint-J�r�me en date du 18
# novembre 2010, dans le cadre du cours �Programmation Orient�e Objet II�, de la technique �Informatique de Gestion�
# 
# #######################################################################
# 
# Main.rb
# Initie les objets de d�part de l'application.
# 
# #######################################################################

# Dimensions de la fen�tre
MAIN_MIN_WIDTH = 800
MAIN_MIN_HEIGHT = 600

require 'Qt4'

app = Qt::Application.new(ARGV)

require 'Interface/Widgets.rb'
require 'Interface/PopUps.rb'
require 'Interface/Fenetre.rb'
require 'Classes Fonctionnelles/SQL.rb'
require 'Classes M�tiers/Manuel.rb'
#require 'Erreurs/GestionErreurs.rb'

iconLogo = Qt::Icon.new('img\LOGO\logo_16x.png')
	
app.setWindowIcon(iconLogo)

window = Fenetre.new()
window.resize(MAIN_MIN_WIDTH, MAIN_MIN_HEIGHT)
window.show()

app.exec()