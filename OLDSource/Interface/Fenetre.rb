# #######################################################################
# 
# Contient les classes et sous-classes pour créer et afficher les différentes fenêtre de menus de l'application.
# 
# #######################################################################

require 'Interface/Contenu.rb'
require 'Interface/APropos.rb'
#require 'Classes Métiers/Manuel.rb'

# Constantes
# --------------

# Constantes de grandeurs
LINE_HEIGHT = 25 # Hauteur optimale d'un contrôle

# Contantes de contenu
CONTENU_VIDE             = 0
CONTENU_MENU_PRIN        = CONTENU_VIDE+1
CONTENU_NEW_PERSO_BASE   = CONTENU_MENU_PRIN+1
CONTENU_NEW_PERSO_CLASSE = CONTENU_NEW_PERSO_BASE+1
CONTENU_NEW_PERSO_ATTR   = CONTENU_NEW_PERSO_CLASSE+1
CONTENU_NEW_PERSO_COMP   = CONTENU_NEW_PERSO_ATTR+1
CONTENU_NEW_PERSO_SORTS  = CONTENU_NEW_PERSO_COMP+1
CONTENU_NEW_PERSO_DONS   = CONTENU_NEW_PERSO_SORTS+1
CONTENU_NEW_PERSO_INFOS  = CONTENU_NEW_PERSO_DONS+1
CONTENU_NEW_PERSO_RESUME = CONTENU_NEW_PERSO_INFOS+1

# Contenu du manuel
CONTENU_M_ACCUEIL = CONTENU_VIDE+50

# Contenu du rouleur
CONTENU_ROULEUR = CONTENU_VIDE+100


# Classe de la fenêtre
class Fenetre < Qt::MainWindow
	# Flux de Qt
	slots 'nouveauPerso()', 
	      'prochaineEtape()', 
		  'ancienneEtape()', 
		  'ouvrirFermerManuel()', 
		  'manuelHidden()', 
		  'mainMenu()',
		  'ouvrirBd()'# TEST
	
	# Les menus
	attr_reader :barreMenu     # La barre de menu sous le titre de la fenêtre
	
	attr_reader :menuFichier   # Le menu de fichier
	attr_reader :menuAide      # Le menu d'aide
	
	attr_reader :subMenuManuel # Le sous menu du manuel dans l'aide
	
	# Les actions
	attr_reader :actFNouveau   # Nouveau personnage
	attr_reader :actFOuvrir    # Visualiser un personnage
	
	attr_reader :actFOuvrirBd  # Ouvrir la BD - TEST
	
	attr_reader :actFImport    # Importer un personnage
	attr_reader :actFExport    # Exporter un personnage
	attr_reader :actFQuitter   # Quitter l'application
	
	attr_reader :actHAPropos   # À propos de l'application
	attr_reader :actHAProposQt # À propos de Qt
	attr_reader :actHMOuvrir   # Ouvrir le manuel
	
	# Les contenus
	attr_reader :contenuActif # Contenu actif de la fenêtre
	attr_reader :idContenu    # Numéro du contenu actif
	
	def initialize()
		super
		
		$StatSeed = nil
		
		# Initialisation de la fenêtre «À Propos»
		@APropos = APropos.new()
		
		# Initialisation du manuel
		@winManuel = Manuel.new(parentWidget())
		connect(@winManuel, SIGNAL('hidding()'), self, SLOT('manuelHidden()'))
		
		# Fonctions d'initialisation des élément de la fenêtre
		createMenu()  # Barre de menu
		
		# Création du contenu
		newContent(CONTENU_MENU_PRIN)
		
		# Propriétés de la fenêtre
		setMinimumSize(800, 600) # Dimensions minimales
	end
	
	def createMenu()
		@barreMenu = Qt::MenuBar.new()
		
		# Menu Fichier
		@menuFichier = @barreMenu.addMenu(tr('&Fichier'))
		createFileActions(@menuFichier)
		# Menu Aide
		@menuAide = @barreMenu.addMenu(tr('&Aide'))
		createHelpActions(@menuAide)
		
		setMenuWidget(@barreMenu)
	end
	
	def createFileActions(menu)
		# Faire un nouveau personnage
		@actFNouveau = Qt::Action.new(tr('&Nouveau personnage'), self)
		@actFNouveau.setShortcut('Ctrl+N')
		@actFNouveau.setStatusTip(tr("Créer une nouvelle fiche de personnage"))
		@actFNouveau.setToolTip(tr("Créer une nouvelle fiche de personnage"))
		@actFNouveau.setEnabled(false)
		@actFNouveau.setVisible(false)
		connect(@actFNouveau, SIGNAL('triggered()'), self, SLOT('nouveauPerso()'))
		
		menu.addAction(@actFNouveau)
		
		#Annuler la création de personnage
		@actFAnnuler = Qt::Action.new(tr('Annuler'), self)
		#@actFAnnuler.setShortcut('Ctrl+N')
		@actFAnnuler.setStatusTip(tr("Annuler la création du personnage"))
		@actFAnnuler.setToolTip(tr("Annuler la création du personnage"))
		@actFAnnuler.setEnabled(false)
		@actFAnnuler.setVisible(false)
		connect(@actFAnnuler, SIGNAL('triggered()'), self, SLOT('mainMenu()'))
		
		menu.addAction(@actFAnnuler)
		
		# Voir un personnage
		@actFOuvrir = Qt::Action.new(tr('&Voir personnage'), self)
		@actFOuvrir.setShortcut('Ctrl+V')
		@actFOuvrir.setStatusTip(tr("Visualiser un personnage"))
		@actFOuvrir.setToolTip(tr("Visualiser un personnage"))
		@actFOuvrir.setEnabled(false)
		@actFOuvrir.setVisible(false)
		
		menu.addAction(@actFOuvrir)
		
		# Voir un personnage
		#@actFOuvrirBd = Qt::Action.new(tr('Ouvrir BD'), self)
		#@actFOuvrirBd.setShortcut('')
		#@actFOuvrirBd.setStatusTip(tr("Visualiser un personnage"))
		#@actFOuvrirBd.setToolTip(tr("Visualiser un personnage"))
		#@actFOuvrirBd.setEnabled(true)
		#@actFOuvrirBd.setVisible(true)
		#connect(@actFOuvrirBd, SIGNAL('triggered()'), self, SLOT('ouvrirBd()'))
		
		#menu.addAction(@actFOuvrirBd)
		
		# --- Séparation ---
		menu.addSeparator()
		
		# Importer un personnage
		@actFImport = Qt::Action.new(tr('&Importer un personnage'), self)
		@actFImport.setShortcut('Ctrl+I')
		@actFImport.setStatusTip(tr("Ajouter un personnage exporté à l'application"))
		@actFImport.setToolTip(tr("Ajouter un personnage exporté à l'application"))
		@actFImport.setEnabled(false)
		@actFImport.setVisible(false)
		
		menu.addAction(@actFImport)
		
		# Exporter un personnage
		@actFExport = Qt::Action.new(tr('&Exporter un personnage'), self)
		@actFExport.setShortcut('Ctrl+E')
		@actFExport.setStatusTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
		@actFExport.setToolTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
		@actFExport.setEnabled(false)
		@actFExport.setVisible(false)
		
		menu.addAction(@actFExport)
		
		# --- Séparation ---
		menu.addSeparator()
		
		# Quitter
		@actFQuitter = Qt::Action.new(tr('&Quitter'), self)
		@actFQuitter.setShortcut('Ctrl+Q')
		@actFQuitter.setStatusTip(tr("Quitter l'application"))
		@actFQuitter.setToolTip(tr("Quitter l'application"))
		connect(@actFQuitter, SIGNAL('triggered()'), $qApp, SLOT('quit()'))
		
		menu.addAction(@actFQuitter)
	end
	
	def createHelpActions(menu)
		# Sous-menu Manuel
		@subMenuManuel = menu.addMenu(tr('&Manuel'))
		createSubManualActions(@subMenuManuel)
		@subMenuManuel.setEnabled(true)
		
		# --- Séparation ---
		menu.addSeparator()
		
		# À propos
		@actHAPropos = Qt::Action.new(tr('À Propos'), self)
		@actHAPropos.setStatusTip(tr("Informations sur l'application"))
		@actHAPropos.setToolTip(tr("Informations sur l'application"))
		connect(@actHAPropos, SIGNAL('triggered()'), @APropos, SLOT('show()'))
		
		menu.addAction(@actHAPropos)
		
		# À propos de Qt
		@actHAProposQT = Qt::Action.new(tr('À Propos de &Qt'), self)
		@actHAProposQT.setStatusTip(tr("Informations sur l'application"))
		@actHAProposQT.setToolTip(tr("Informations sur l'application"))
		connect(@actHAProposQT, SIGNAL('triggered()'), $qApp, SLOT('aboutQt()'))
		
		menu.addAction(@actHAProposQT)
	end
	
	def createSubManualActions(menu)
		# Ouvrir
		@actHMOuvrir = Qt::Action.new(tr('Ouvrir'), self)
		@actHMOuvrir.setShortcut('Ctrl+M')
		@actHMOuvrir.setStatusTip(tr("Ouvrir le manuel"))
		@actHMOuvrir.setToolTip(tr("Ouvrir le manuel"))
		@actHMOuvrir.setEnabled(true)
		connect(@actHMOuvrir, SIGNAL('triggered()'), self, SLOT('ouvrirFermerManuel()'))
		
		menu.addAction(@actHMOuvrir)
	end
	
	def drawContent
		setCentralWidget(@contenuActif)
	end
	
	def setWindowTitle(strTitre = "")
		strNTitre = "JeRoFa"
		
		if strTitre != ""
			strNTitre += " - " + strTitre
		end
		
		super(strNTitre)
	end
	
	def newContent(contenu)
		# Valeurs par défaut
		@actFNouveau.setEnabled(false)
		@actFAnnuler.setEnabled(false)
		
		@actFNouveau.setVisible(false)
		@actFAnnuler.setVisible(false)
		@actFOuvrir.setVisible(false)
		@actFImport.setVisible(false)
		@actFExport.setVisible(false)
		
		setWindowTitle()
		
		# Nouvelles valeurs
		case contenu
		when CONTENU_VIDE # Contenu de tests
			@contenuActif = Contenu.new()
			@idContenu = CONTENU_VIDE
			
		when CONTENU_MENU_PRIN # Menu Principal
			srand()
			@contenuActif = MenuPrincipal.new()
			
			if $bd.blnFonctionnel
				@actFNouveau.setEnabled(true) # On peut créer un personnage
			end
			
			@actFNouveau.setVisible(true) # On pourrait créer un personnage
			setWindowTitle('Menu Principal')
			@idContenu = CONTENU_MENU_PRIN
			
		when CONTENU_NEW_PERSO_BASE # Création de personnage - Étape 1
			@contenuActif = CreationPerso_Perso.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_BASE
			
		when CONTENU_NEW_PERSO_CLASSE # Création de personnage - Étape 2
			@contenuActif = CreationPerso_Classe.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_CLASSE
			
		when CONTENU_NEW_PERSO_ATTR # Création de personnage - Étape 3
			@contenuActif = CreationPerso_Attributs.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_ATTR
			
		when CONTENU_NEW_PERSO_COMP # Création de personnage - Étape 4
			@contenuActif = CreationPerso_Competences.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_COMP
			
		when CONTENU_NEW_PERSO_SORTS # Création de personnage - Étape 5
			@contenuActif = CreationPerso_Sorts.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_SORTS
			
		when CONTENU_NEW_PERSO_DONS # Création de personnage - Étape 6
			@contenuActif = CreationPerso_Dons.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_DONS
			
		when CONTENU_NEW_PERSO_INFOS # Création de personnage - Étape 7
			@contenuActif = CreationPerso_Infos.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_INFOS
			
		when CONTENU_NEW_PERSO_RESUME # Création de personnage - Étape 8
			@contenuActif = CreationPerso_Resume.new()
			connect(@contenuActif, SIGNAL('mainMenu()'), self, SLOT('mainMenu()'))
			connect(@contenuActif, SIGNAL('nextStep()'), self, SLOT('prochaineEtape()'))
			connect(@contenuActif, SIGNAL('previous()'), self, SLOT('ancienneEtape()'))
			@actFAnnuler.setEnabled(true) # On peut annuler la création
			@actFAnnuler.setVisible(true) # On peut annuler la création
			setWindowTitle('Création de personnage')
			@idContenu = CONTENU_NEW_PERSO_RESUME
		end
		
		drawContent()
	end
	
	def nouveauPerso()
		$NewCharMod = false
		newContent(CONTENU_NEW_PERSO_BASE)
	end
	
	def ouvrirFermerManuel()
		# Afficher ou cacher le manuel
		if @winManuel.isVisible()
			@actHMOuvrir.setText(tr("Ouvrir"))
			@winManuel.hide()
		else
			@actHMOuvrir.setText(tr("Fermer"))
			@winManuel.show()
		end
	end
	
	def manuelHidden()
		@actHMOuvrir.setText(tr("Ouvrir"))
	end
	
	def mainMenu()
		newContent(CONTENU_MENU_PRIN)
	end
	
	def prochaineEtape
		case @idContenu
		when CONTENU_NEW_PERSO_BASE
			newContent(CONTENU_NEW_PERSO_CLASSE)
		when CONTENU_NEW_PERSO_CLASSE
			newContent(CONTENU_NEW_PERSO_ATTR)
		when CONTENU_NEW_PERSO_ATTR
			newContent(CONTENU_NEW_PERSO_COMP)
		when CONTENU_NEW_PERSO_COMP
			newContent(CONTENU_NEW_PERSO_SORTS)
		when CONTENU_NEW_PERSO_SORTS
			newContent(CONTENU_NEW_PERSO_DONS)
		when CONTENU_NEW_PERSO_DONS
			newContent(CONTENU_NEW_PERSO_INFOS)
		when CONTENU_NEW_PERSO_INFOS
			newContent(CONTENU_NEW_PERSO_RESUME)
		when CONTENU_NEW_PERSO_RESUME
			newContent(CONTENU_NEW_PERSO_RESUME)
		end
	end
	
	def ancienneEtape
		case idContenu
		when CONTENU_NEW_PERSO_CLASSE
			newContent(CONTENU_NEW_PERSO_BASE)
		when CONTENU_NEW_PERSO_ATTR
			newContent(CONTENU_NEW_PERSO_CLASSE)
		when CONTENU_NEW_PERSO_COMP
			newContent(CONTENU_NEW_PERSO_ATTR)
		when CONTENU_NEW_PERSO_SORTS
			newContent(CONTENU_NEW_PERSO_COMP)
		when CONTENU_NEW_PERSO_DONS
			newContent(CONTENU_NEW_PERSO_SORTS)
		when CONTENU_NEW_PERSO_INFOS
			newContent(CONTENU_NEW_PERSO_DONS)
		when CONTENU_NEW_PERSO_RESUME
			newContent(CONTENU_NEW_PERSO_INFOS)
		end
	end
	
	#def ouvrirBd()
	#	test = IniSQL.new()
	#	
	#	if !test.blnFonctionnel
	#		MessageOk.new(tr('Erreur de connexion à la base de données :') + "\n" + test.errMess)
	#	end
	#end
end

# Classe du manuel
class Manuel < Qt::MainWindow
	# Flux de Qt
	signals 'hidding()'
	slots 'makeHidden()'
	
	# Les menus
	attr_reader :barreMenu     # La barre de menu sous le titre de la fenêtre
	
	attr_reader :menuFichier   # Le menu de fichier
	#attr_reader :menuAide      # Le menu d'aide
	
	#attr_reader :subMenuManuel # Le sous menu du manuel dans l'aide
	
	# Les actions
	#attr_reader :actFNouveau   # Nouveau personnage
	#attr_reader :actFOuvrir    # Visualiser un personnage
	#attr_reader :actFImport    # Importer un personnage
	#attr_reader :actFExport    # Exporter un personnage
	attr_reader :actFQuitter   # Quitter l'application
	
	#attr_reader :actHAPropos   # À propos de l'application
	#attr_reader :actHAProposQt # À propos de Qt
	#attr_reader :actHMOuvrir   # Ouvrir le manuel
	
	# Les contenus
	attr_reader :contenuActif # Contenu actif de la fenêtre
	
	def initialize(parent = $qApp)
		super
		
		# Initialisation de la fenêtre «À Propos»
		@APropos = APropos.new()
		
		# Fonctions d'initialisation des élément de la fenêtre
		createMenu()  # Barre de menu
		
		# Création du contenu
		newContent(CONTENU_M_ACCUEIL)
		
		# Propriétés de la fenêtre
		setMinimumSize(640, 480) # Dimensions minimales
	end
	
	def createMenu()
		@barreMenu = Qt::MenuBar.new()
		
		# Menu Fichier
		@menuFichier = @barreMenu.addMenu(tr('&Fichier'))
		createFileActions(@menuFichier)
		# Menu Aide
		#@menuAide = @barreMenu.addMenu(tr('&Aide'))
		#createHelpActions(@menuAide)
		
		setMenuWidget(@barreMenu)
	end
	
	def createFileActions(menu)
		# Faire un nouveau personnage
#		@actFNouveau = Qt::Action.new(tr('&Nouveau personnage'), self)
#		@actFNouveau.setShortcut('Ctrl+N')
#		@actFNouveau.setStatusTip(tr("Créer une nouvelle fiche de personnage"))
#		@actFNouveau.setToolTip(tr("Créer une nouvelle fiche de personnage"))
#		@actFNouveau.setEnabled(false)
#		#connect(@actFNouveau, SIGNAL('triggered()'), self, SLOT('nouveauPerso()'))
		
#		menu.addAction(@actFNouveau)
		
		# Voir un personnage
#		@actFOuvrir = Qt::Action.new(tr('&Voir personnage'), self)
#		@actFOuvrir.setShortcut('Ctrl+V')
#		@actFOuvrir.setStatusTip(tr("Visualiser un personnage"))
#		@actFOuvrir.setToolTip(tr("Visualiser un personnage"))
#		@actFOuvrir.setEnabled(false)
		
#		menu.addAction(@actFOuvrir)
		
		# --- Séparation ---
#		menu.addSeparator()
		
		# Importer un personnage
#		@actFImport = Qt::Action.new(tr('&Importer un personnage'), self)
#		@actFImport.setShortcut('Ctrl+I')
#		@actFImport.setStatusTip(tr("Ajouter un personnage exporté à l'application"))
#		@actFImport.setToolTip(tr("Ajouter un personnage exporté à l'application"))
#		@actFImport.setEnabled(false)
		
#		menu.addAction(@actFImport)
		
		# Exporter un personnage
#		@actFExport = Qt::Action.new(tr('&Exporter un personnage'), self)
#		@actFExport.setShortcut('Ctrl+E')
#		@actFExport.setStatusTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
#		@actFExport.setToolTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
#		@actFExport.setEnabled(false)
		
#		menu.addAction(@actFExport)
		
		# --- Séparation ---
#		menu.addSeparator()
		
		# Quitter
		@actFQuitter = Qt::Action.new(tr('&Fermer'), self)
		@actFQuitter.setShortcut('Ctrl+M')
		@actFQuitter.setStatusTip(tr("Fermer le manuel"))
		@actFQuitter.setToolTip(tr("Fermer le manuel"))
		connect(@actFQuitter, SIGNAL('triggered()'), self, SLOT('makeHidden()'))
		
		menu.addAction(@actFQuitter)
	end
	
#	def createHelpActions(menu)
#		# Sous-menu Manuel
#		@subMenuManuel = menu.addMenu(tr('&Manuel'))
#		createSubManualActions(@subMenuManuel)
#		@subMenuManuel.setEnabled(false)
#		
#		# --- Séparation ---
#		menu.addSeparator()
#		
#		# À propos
#		@actHAPropos = Qt::Action.new(tr('À Propos'), self)
#		@actHAPropos.setStatusTip(tr("Informations sur l'application"))
#		@actHAPropos.setToolTip(tr("Informations sur l'application"))
#		connect(@actHAPropos, SIGNAL('triggered()'), @APropos, SLOT('show()'))
#		
#		menu.addAction(@actHAPropos)
#		
#		# À propos de Qt
#		@actHAProposQT = Qt::Action.new(tr('À Propos de &Qt'), self)
#		@actHAProposQT.setStatusTip(tr("Informations sur l'application"))
#		@actHAProposQT.setToolTip(tr("Informations sur l'application"))
#		connect(@actHAProposQT, SIGNAL('triggered()'), $qApp, SLOT('aboutQt()'))
#		
#		menu.addAction(@actHAProposQT)
#	end
	
#	def createSubManualActions(menu)
#		# Ouvrir
#		@actHMOuvrir = Qt::Action.new(tr('Ouvrir'), self)
#		@actHMOuvrir.setShortcut('Ctrl+M')
#		@actHMOuvrir.setStatusTip(tr("Ouvrir le manuel"))
#		@actHMOuvrir.setToolTip(tr("Ouvrir le manuel"))
#		@actHMOuvrir.setEnabled(false)
#		
#		menu.addAction(@actHMOuvrir)
#	end
	
	def drawContent
		setCentralWidget(@contenuActif)
	end
	
	def setWindowTitle(strTitre = "")
		strNTitre = "Manuel JeRoFa"
		
		if strTitre != ""
			strNTitre += " - " + strTitre
		end
		
		super(strNTitre)
	end
	
	def newContent(contenu)
		# Valeurs par défaut
		#@actFNouveau.setEnabled(false)
		setWindowTitle()
		
		# Nouvelles valeurs
		case contenu
		when CONTENU_VIDE # Contenu de tests
			@contenuActif = Contenu.new()
			
		when CONTENU_M_ACCUEIL # Contenu de tests
			@contenuActif = Contenu.new()
			
#		when CONTENU_MENU_PRIN # Menu Principal
#			@contenuActif = MenuPrincipal.new()
#			@actFNouveau.setEnabled(true) # On peut créer un personnage
#			setWindowTitle('Menu Principal')
			
#		when CONTENU_CREATION_PERSO # Création de personnage
#			@contenuActif = MenuPrincipal.new()
#			setWindowTitle('Création de personnage')
			
		end
		
		drawContent()
	end
	
	def closeEvent(event)
		super
		emit hidding()
	end
	
	def makeHidden()
		hide()
		emit hidding()
	end
end

# Classe du manuel
class Rouleur < Qt::MainWindow
	# Flux de Qt
	signals 'hidding()'
	slots 'makeHidden()'
	
	# Les menus
	attr_reader :barreMenu     # La barre de menu sous le titre de la fenêtre
	
	attr_reader :menuFichier   # Le menu de fichier
	#attr_reader :menuAide      # Le menu d'aide
	
	#attr_reader :subMenuManuel # Le sous menu du manuel dans l'aide
	
	# Les actions
	#attr_reader :actFNouveau   # Nouveau personnage
	#attr_reader :actFOuvrir    # Visualiser un personnage
	#attr_reader :actFImport    # Importer un personnage
	#attr_reader :actFExport    # Exporter un personnage
	attr_reader :actFQuitter   # Quitter l'application
	
	#attr_reader :actHAPropos   # À propos de l'application
	#attr_reader :actHAProposQt # À propos de Qt
	#attr_reader :actHMOuvrir   # Ouvrir le manuel
	
	# Les contenus
	attr_reader :contenuActif # Contenu actif de la fenêtre
	
	def initialize(parent = $qApp)
		super
		
		# Initialisation de la fenêtre «À Propos»
		@APropos = APropos.new()
		
		# Fonctions d'initialisation des élément de la fenêtre
		createMenu()  # Barre de menu
		
		# Création du contenu
		newContent(CONTENU_ROULEUR)
		
		# Propriétés de la fenêtre
		setMinimumSize(640, 480) # Dimensions minimales
	end
	
	def createMenu()
		@barreMenu = Qt::MenuBar.new()
		
		# Menu Fichier
		@menuFichier = @barreMenu.addMenu(tr('&Fichier'))
		createFileActions(@menuFichier)
		# Menu Aide
		#@menuAide = @barreMenu.addMenu(tr('&Aide'))
		#createHelpActions(@menuAide)
		
		setMenuWidget(@barreMenu)
	end
	
	def createFileActions(menu)
		# Faire un nouveau personnage
#		@actFNouveau = Qt::Action.new(tr('&Nouveau personnage'), self)
#		@actFNouveau.setShortcut('Ctrl+N')
#		@actFNouveau.setStatusTip(tr("Créer une nouvelle fiche de personnage"))
#		@actFNouveau.setToolTip(tr("Créer une nouvelle fiche de personnage"))
#		@actFNouveau.setEnabled(false)
#		#connect(@actFNouveau, SIGNAL('triggered()'), self, SLOT('nouveauPerso()'))
		
#		menu.addAction(@actFNouveau)
		
		# Voir un personnage
#		@actFOuvrir = Qt::Action.new(tr('&Voir personnage'), self)
#		@actFOuvrir.setShortcut('Ctrl+V')
#		@actFOuvrir.setStatusTip(tr("Visualiser un personnage"))
#		@actFOuvrir.setToolTip(tr("Visualiser un personnage"))
#		@actFOuvrir.setEnabled(false)
		
#		menu.addAction(@actFOuvrir)
		
		# --- Séparation ---
#		menu.addSeparator()
		
		# Importer un personnage
#		@actFImport = Qt::Action.new(tr('&Importer un personnage'), self)
#		@actFImport.setShortcut('Ctrl+I')
#		@actFImport.setStatusTip(tr("Ajouter un personnage exporté à l'application"))
#		@actFImport.setToolTip(tr("Ajouter un personnage exporté à l'application"))
#		@actFImport.setEnabled(false)
		
#		menu.addAction(@actFImport)
		
		# Exporter un personnage
#		@actFExport = Qt::Action.new(tr('&Exporter un personnage'), self)
#		@actFExport.setShortcut('Ctrl+E')
#		@actFExport.setStatusTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
#		@actFExport.setToolTip(tr("Enregister un personnage pour l'importer sur un autre poste ou pour faire une sauvegarde"))
#		@actFExport.setEnabled(false)
		
#		menu.addAction(@actFExport)
		
		# --- Séparation ---
#		menu.addSeparator()
		
		# Quitter
		@actFQuitter = Qt::Action.new(tr('&Fermer'), self)
		@actFQuitter.setShortcut('Ctrl+M')
		@actFQuitter.setStatusTip(tr("Fermer le manuel"))
		@actFQuitter.setToolTip(tr("Fermer le manuel"))
		connect(@actFQuitter, SIGNAL('triggered()'), self, SLOT('makeHidden()'))
		
		menu.addAction(@actFQuitter)
	end
	
#	def createHelpActions(menu)
#		# Sous-menu Manuel
#		@subMenuManuel = menu.addMenu(tr('&Manuel'))
#		createSubManualActions(@subMenuManuel)
#		@subMenuManuel.setEnabled(false)
#		
#		# --- Séparation ---
#		menu.addSeparator()
#		
#		# À propos
#		@actHAPropos = Qt::Action.new(tr('À Propos'), self)
#		@actHAPropos.setStatusTip(tr("Informations sur l'application"))
#		@actHAPropos.setToolTip(tr("Informations sur l'application"))
#		connect(@actHAPropos, SIGNAL('triggered()'), @APropos, SLOT('show()'))
#		
#		menu.addAction(@actHAPropos)
#		
#		# À propos de Qt
#		@actHAProposQT = Qt::Action.new(tr('À Propos de &Qt'), self)
#		@actHAProposQT.setStatusTip(tr("Informations sur l'application"))
#		@actHAProposQT.setToolTip(tr("Informations sur l'application"))
#		connect(@actHAProposQT, SIGNAL('triggered()'), $qApp, SLOT('aboutQt()'))
#		
#		menu.addAction(@actHAProposQT)
#	end
	
#	def createSubManualActions(menu)
#		# Ouvrir
#		@actHMOuvrir = Qt::Action.new(tr('Ouvrir'), self)
#		@actHMOuvrir.setShortcut('Ctrl+M')
#		@actHMOuvrir.setStatusTip(tr("Ouvrir le manuel"))
#		@actHMOuvrir.setToolTip(tr("Ouvrir le manuel"))
#		@actHMOuvrir.setEnabled(false)
#		
#		menu.addAction(@actHMOuvrir)
#	end
	
	def drawContent
		setCentralWidget(@contenuActif)
	end
	
	def setWindowTitle(strTitre = "")
		strNTitre = "Rouleur JeRoFa"
		
		if strTitre != ""
			strNTitre += " - " + strTitre
		end
		
		super(strNTitre)
	end
	
	def newContent(contenu)
		# Valeurs par défaut
		#@actFNouveau.setEnabled(false)
		setWindowTitle()
		
		# Nouvelles valeurs
		case contenu
		when CONTENU_VIDE # Contenu de tests
			@contenuActif = Contenu.new()
			
		when CONTENU_ROULEUR # Contenu de tests
			@contenuActif = Contenu.new()
			
#		when CONTENU_MENU_PRIN # Menu Principal
#			@contenuActif = MenuPrincipal.new()
#			@actFNouveau.setEnabled(true) # On peut créer un personnage
#			setWindowTitle('Menu Principal')
			
#		when CONTENU_CREATION_PERSO # Création de personnage
#			@contenuActif = MenuPrincipal.new()
#			setWindowTitle('Création de personnage')
			
		end
		
		drawContent()
	end
	
	def closeEvent(event)
		super
		emit hidding()
	end
	
	def makeHidden()
		hide()
		emit hidding()
	end
end

# Menu Principal
#class MenuPrincipal < Fenetre
#	def initialize()
#		super
#		
#		# Activation des actions possibles
#		@actFNouveau.setEnabled(true) # On peut créer un personnage
#		
#		# Définition des propriétés
#		setWindowTitle('Menu Principal') # Nom de la fenêtre
#	end
#	
#	def drawContent()
#		@fond = ContenuMenuPrin.new()
#		setCentralWidget(@fond)
#		#update()
#	end
#end