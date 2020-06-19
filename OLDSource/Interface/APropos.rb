# #######################################################################
# 
# Permet la création de la boîte de dialogue «À Propos».
# 
# #######################################################################

require 'Interface/PopUps.rb'

class APropos < PopUp
	TEXT_WIDTH = 400

	def initialize()
		# Logo JeRoFa
		logo = Qt::Pixmap.new('img\LOGO\logo_64x.png')
		
		# Étiquette contenant le logo
		logoLabel = Qt::Label.new()
		logoLabel.setPixmap(logo)
		logoLabel.setFixedSize(64, 64)
		#logoLabel.setWordWrap(true)
		logoLabel.setAlignment(Qt::AlignHCenter + Qt::AlignVCenter)
		
		# Texte de la boîte «À Propos»
		texte = tr("<i>JeRoFa</i> (<b>Je</b>u de <b>Rô</b>le <b>Fa</b>cile) est un logiciel pour" +
		        " assister un maître de donjon dans le jeu Donjons et Dragons (<a href='http://www.wizards.com/'>Wizards of the Coast</a>)." +
		        "<br/>Le présent logiciel est lui-même propriété de <b>Jean-François Brun</b>, <b>Jean-Michel Beauvais</b>" +
				" et du Cegep de Saint-Jérôme (Novembre 2010).<br/><br/>" +
				"Le logo du dés à 20 faces est propriété de <b>Sébastien Pruneau</b> et du Cegep Saint-Jérôme (Novembre 2010).")
		
		# Étiquette contenant le texte
		textLabel = Qt::Label.new()
		textLabel.setText(tr(texte))
		textLabel.setFixedWidth(TEXT_WIDTH)
		textLabel.setFixedHeight(TEXT_WIDTH/2)
		textLabel.setTextFormat(Qt::RichText)
		textLabel.setWordWrap(true)
		textLabel.setAlignment(Qt::AlignTop)
		
		# Bouton pour fermer(cacher) la fenêtre
		bouton = Qt::PushButton.new(tr('Fermer'))
		bouton.setFixedSize(75, LINE_HEIGHT)
		
		
		# Disposition des objets dans la fenêtre
		setDispoPrin
		
		@dispoPrincipale.addWidget(logoLabel, 0, 0)
		@dispoPrincipale.setAlignment(logoLabel, Qt::AlignTop)
		
		@dispoPrincipale.addWidget(textLabel, 0, 1)
		@dispoPrincipale.setAlignment(textLabel, Qt::AlignTop)
		
		@dispoPrincipale.addWidget(bouton, 1, 0, 2,2)
		@dispoPrincipale.setAlignment(bouton, Qt::AlignHCenter)
		
		super
		
		setWindowTitle(tr('À Propos')) # Titre de la fenêtre
		connect(bouton, SIGNAL('clicked()'), self, SLOT('hide()'))
	end
end