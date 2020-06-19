# #######################################################################
# 
# Permet la cr�ation de la bo�te de dialogue �� Propos�.
# 
# #######################################################################

require 'Interface/PopUps.rb'

class APropos < PopUp
	TEXT_WIDTH = 400

	def initialize()
		# Logo JeRoFa
		logo = Qt::Pixmap.new('img\LOGO\logo_64x.png')
		
		# �tiquette contenant le logo
		logoLabel = Qt::Label.new()
		logoLabel.setPixmap(logo)
		logoLabel.setFixedSize(64, 64)
		#logoLabel.setWordWrap(true)
		logoLabel.setAlignment(Qt::AlignHCenter + Qt::AlignVCenter)
		
		# Texte de la bo�te �� Propos�
		texte = tr("<i>JeRoFa</i> (<b>Je</b>u de <b>R�</b>le <b>Fa</b>cile) est un logiciel pour" +
		        " assister un ma�tre de donjon dans le jeu Donjons et Dragons (<a href='http://www.wizards.com/'>Wizards of the Coast</a>)." +
		        "<br/>Le pr�sent logiciel est lui-m�me propri�t� de <b>Jean-Fran�ois Brun</b>, <b>Jean-Michel Beauvais</b>" +
				" et du Cegep de Saint-J�r�me (Novembre 2010).<br/><br/>" +
				"Le logo du d�s � 20 faces est propri�t� de <b>S�bastien Pruneau</b> et du Cegep Saint-J�r�me (Novembre 2010).")
		
		# �tiquette contenant le texte
		textLabel = Qt::Label.new()
		textLabel.setText(tr(texte))
		textLabel.setFixedWidth(TEXT_WIDTH)
		textLabel.setFixedHeight(TEXT_WIDTH/2)
		textLabel.setTextFormat(Qt::RichText)
		textLabel.setWordWrap(true)
		textLabel.setAlignment(Qt::AlignTop)
		
		# Bouton pour fermer(cacher) la fen�tre
		bouton = Qt::PushButton.new(tr('Fermer'))
		bouton.setFixedSize(75, LINE_HEIGHT)
		
		
		# Disposition des objets dans la fen�tre
		setDispoPrin
		
		@dispoPrincipale.addWidget(logoLabel, 0, 0)
		@dispoPrincipale.setAlignment(logoLabel, Qt::AlignTop)
		
		@dispoPrincipale.addWidget(textLabel, 0, 1)
		@dispoPrincipale.setAlignment(textLabel, Qt::AlignTop)
		
		@dispoPrincipale.addWidget(bouton, 1, 0, 2,2)
		@dispoPrincipale.setAlignment(bouton, Qt::AlignHCenter)
		
		super
		
		setWindowTitle(tr('� Propos')) # Titre de la fen�tre
		connect(bouton, SIGNAL('clicked()'), self, SLOT('hide()'))
	end
end