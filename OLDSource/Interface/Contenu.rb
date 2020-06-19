# #######################################################################
# 
# Contient le contenu des fenêtres de l'application
# 
# #######################################################################

require 'Classes Fonctionnelles/Des.rb'

# Identifiants des étapes de création de personnage
ETAPE_1 = 1
ETAPE_2 = ETAPE_1+1
ETAPE_3 = ETAPE_2+1
ETAPE_4 = ETAPE_3+1
ETAPE_5 = ETAPE_4+1
ETAPE_6 = ETAPE_5+1
ETAPE_7 = ETAPE_6+1

# Couleur du manuel
MANUAL_COLOR = Qt::Color.new(120,120,150)

# Classe mère des contenus
class Contenu < Qt::Widget
	# Flux
	signals 'mainMenu()'
	
	attr_reader :mainScreen # Écran d'affichage principal
	
	def initialize()
		super
		
		# Couleur de fond
		setBackColor(Qt::Color.new(230, 230, 230))
	end
	
	# Changer la couleur de fond
	def setBackColor(newColor)
		setPalette(Qt::Palette.new(newColor))
		setAutoFillBackground(true)
	end
	
	def createScreens()
		@mainScreen = Qt::VBoxLayout.new()
		
		txtTitre = tr("")
		
		@lblTitre = Qt::Label.new(txtTitre)
		@lblTitre.setTextFormat(Qt::RichText)
		
		@mainScreen.addWidget(@lblTitre)
		@mainScreen.setAlignment(@lblTitre, Qt::AlignHCenter + Qt::AlignTop)
	end
end

# Contenu du menu principal
class MenuPrincipal < Contenu
	def initialize()
		super
		
		# Création des écrans
		createScreens()
		
		# Écran principal
		setLayout(@mainScreen)
	end
	
	# Crée les écrans du menu
	def createScreens
		super
		# --- Écran Principal ---
		
		# Titre
		txtTitre = tr("<span style='font-size:+50pt;'>JeRoFa</span>")
		@lblTitre.setText(txtTitre)
		
		# Corps de texte
		txtCorps = tr("Pour débuter, utilisez le menu «Fichiers» et choisissez l'option «Nouveau personnage».")
		lblCorps = Qt::Label.new(txtCorps)
		lblCorps.setTextFormat(Qt::RichText)
		
		# Assemblage des éléments
		@mainScreen.addWidget(lblCorps)
		@mainScreen.setAlignment(lblCorps, Qt::AlignHCenter + Qt::AlignTop)
	end
end

# Contenu du menu principal
class CreationPerso < Contenu
	# Flux
	signals 'previous()', 'nextStep()'
	slots 'changing()', 'changingN()'
	
	# Attributs
	@@nom = ''
	@@sexe = 0
	@@race = 0
	@@alignment = 0
	@@cheveux = 0
	@@yeux = 0
	@@age = ''
	@@taille = ''
	@@poids = ''
	
	@@classe = 0
	
	@@carac = Array.new()
	
	@@compClasse = Array.new()
	@@compHClasse = Array.new()
	
	@@sorts = Array.new()
	
	@@dons = Array.new()
	
	@@histoire = ''
	@@caractere = ''
	
	def initialize()
		super
		
		# Création des écrans
		createScreens()
		
		# Écran principal
		setLayout(@mainScreen)
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createFootLayout()
		@mainScreen.addLayout(@dispoPied)
	end
	
	def createFootLayout()
		@dispoPied = Qt::HBoxLayout.new()
		
		@cmdPrevious = Qt::PushButton.new(tr('< &Précédent'))
		connect(@cmdPrevious, SIGNAL('clicked()'), self, SLOT('changing()'))
		connect(@cmdPrevious, SIGNAL('clicked()'), self, SIGNAL('previous()'))
		@cmdNext = Qt::PushButton.new(tr('&Suivant >'))
		connect(@cmdNext, SIGNAL('clicked()'), self, SLOT('changingN()'))
		
		@dispoPied.addWidget(@cmdPrevious)
		@dispoPied.setAlignment(@cmdPrevious, Qt::AlignLeft + Qt::AlignVCenter)
		
		@dispoPied.addWidget(@cmdNext)
		@dispoPied.setAlignment(@cmdNext, Qt::AlignRight + Qt::AlignVCenter)
		@dispoPied.setSpacing(0.75*MAIN_MIN_WIDTH)
	end
	
	def changing()
	end
	
	def changingN()
		if validateStep
			changing()
			emit nextStep()
		end
	end
	
	def validateStep()
		return true
	end
end

# Contenu du menu principal
class CreationPerso_Perso < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		super
		connect(self, SIGNAL('previous()'), self, SIGNAL('mainMenu()'))
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 1 - Le personnage ---
		
		# Titre
		txtTitrePerso = tr("<span style='font-size:+50pt;'>Étape 1 - Le Personnage</span>")
		@lblTitre.setText(txtTitrePerso)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		lblNomPerso = Qt::Label.new(tr("Nom :"))
		lblSexe = Qt::Label.new(tr("Sexe :"))
		lblAlignment = Qt::Label.new(tr("Alignement :"))
		lblRace = Qt::Label.new(tr("Race :"))
		
		@dispoCorps.addWidget(lblNomPerso, 1, 1)
		@dispoCorps.setAlignment(lblNomPerso, Qt::AlignLeft)
		
		@dispoCorps.addWidget(lblSexe, 2, 1)
		@dispoCorps.setAlignment(lblSexe, Qt::AlignLeft)
		
		@dispoCorps.addWidget(lblAlignment, 3, 1)
		@dispoCorps.setAlignment(lblAlignment, Qt::AlignLeft)
		
		@dispoCorps.addWidget(lblRace, 4, 1)
		@dispoCorps.setAlignment(lblRace, Qt::AlignLeft)
		
		@dispoCorps.addWidget(@lneNomPerso, 1, 2)
		@dispoCorps.setAlignment(@lneNomPerso, Qt::AlignRight)
		
		@dispoCorps.addWidget(@cmbSexe, 2, 2)
		@dispoCorps.setAlignment(@cmbSexe, Qt::AlignRight)
		
		@dispoCorps.addWidget(@cmbAlignment, 3, 2)
		@dispoCorps.setAlignment(@cmbAlignment, Qt::AlignRight)
		
		@dispoCorps.addWidget(@cmbRace, 4, 2)
		@dispoCorps.setAlignment(@cmbRace, Qt::AlignRight)
		
		@dispoCorps.addWidget(@grpCaracPhys, 5, 1, 7, 2)
		@dispoCorps.setAlignment(@grpCaracPhys, Qt::AlignHCenter + Qt::AlignTop)
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		#@mainScreen.setSpacing(1)
		
		@cmdPrevious.setText(tr('Annuler'))
	end
	
	def createDataObjects()
		# Étape 1 -----------------------------------
		
		if $DEBUG
			puts '------LOADING------'
		end
		
		@lneNomPerso = Qt::LineEdit.new()
		@lneNomPerso.setFixedWidth(150)
		
		if $DEBUG
			puts 'NOM : ' + @@nom.to_s
		end
		
		@lneNomPerso.setText(@@nom)
		
		@cmbSexe = Qt::ComboBox.new()
		@cmbSexe.setFixedWidth(150)
		@cmbSexe.setMaxVisibleItems(4)
		fillCmbSexe()
		
		if $DEBUG
			puts 'SEX : ' + @@sexe.to_s
		end
		
		@cmbSexe.setCurrentIndex(@@sexe)
		
		@cmbAlignment = Qt::ComboBox.new()
		@cmbAlignment.setFixedWidth(150)
		@cmbAlignment.setMaxVisibleItems(4)
		fillCmbAlignment()
		
		if $DEBUG
			puts 'ALIGN : ' + @@alignment.to_s
		end
		
		@cmbAlignment.setCurrentIndex(@@alignment)
		
		@cmbRace = Qt::ComboBox.new()
		@cmbRace.setFixedWidth(150)
		@cmbRace.setMaxVisibleItems(4)
		fillCmbRace()
		
		if $DEBUG
			puts 'RACE : ' + @@race.to_s
		end
		
		@cmbRace.setCurrentIndex(@@race)
		
		# Caractéristiques physiques
		
		@grpCaracPhys = Qt::GroupBox.new(tr('Caractéristiques physiques'))
		dispoCaracPhys = Qt::GridLayout.new()
		
		lblCheveux = Qt::Label.new(tr('Cheveux :'))
		
		@cmbCheveux = Qt::ComboBox.new()
		@cmbCheveux.setFixedWidth(150)
		@cmbCheveux.setMaxVisibleItems(4)
		fillCmbCheveux()
		@cmbCheveux.setCurrentIndex(@@cheveux)
		
		lblYeux = Qt::Label.new(tr('Yeux :'))
		
		@cmbYeux = Qt::ComboBox.new()
		@cmbYeux.setFixedWidth(150)
		@cmbYeux.setMaxVisibleItems(5)
		fillCmbYeux()
		@cmbYeux.setCurrentIndex(@@yeux)
		
		numValid = Qt::IntValidator.new(1, 9999, self)
		
		lblAge = Qt::Label.new(tr('Âge :'))
		
		@lneAge = Qt::LineEdit.new()
		@lneAge.setFixedWidth(150)
		@lneAge.setValidator(numValid)
		@lneAge.setText(@@age)
		
		lblTaille = Qt::Label.new(tr('Taille (en pieds) :'))
		
		@lneTaille = Qt::LineEdit.new()
		@lneTaille.setFixedWidth(150)
		@lneTaille.setValidator(numValid)
		@lneTaille.setText(@@taille)
		
		lblPoids = Qt::Label.new(tr('Poids (en lbs) :'))
		
		@lnePoids = Qt::LineEdit.new()
		@lnePoids.setFixedWidth(150)
		@lnePoids.setValidator(numValid)
		@lnePoids.setText(@@poids)
		
		dispoCaracPhys.addWidget(lblCheveux, 0, 0)
		dispoCaracPhys.setAlignment(lblCheveux, Qt::AlignLeft)
		
		dispoCaracPhys.addWidget(@cmbCheveux, 0, 1)
		dispoCaracPhys.setAlignment(@cmbCheveux, Qt::AlignRight)
		
		dispoCaracPhys.addWidget(lblYeux, 1, 0)
		dispoCaracPhys.setAlignment(lblYeux, Qt::AlignLeft)
		
		dispoCaracPhys.addWidget(@cmbYeux, 1, 1)
		dispoCaracPhys.setAlignment(@cmbYeux, Qt::AlignRight)
		
		dispoCaracPhys.addWidget(lblAge, 2, 0)
		dispoCaracPhys.setAlignment(lblAge, Qt::AlignLeft)
		
		dispoCaracPhys.addWidget(@lneAge, 2, 1)
		dispoCaracPhys.setAlignment(@lneAge, Qt::AlignRight)
		
		dispoCaracPhys.addWidget(lblTaille, 3, 0)
		dispoCaracPhys.setAlignment(lblTaille, Qt::AlignLeft)
		
		dispoCaracPhys.addWidget(@lneTaille, 3, 1)
		dispoCaracPhys.setAlignment(@lneTaille, Qt::AlignRight)
		
		dispoCaracPhys.addWidget(lblPoids, 4, 0)
		dispoCaracPhys.setAlignment(lblPoids, Qt::AlignLeft)
		
		dispoCaracPhys.addWidget(@lnePoids, 4, 1)
		dispoCaracPhys.setAlignment(@lnePoids, Qt::AlignRight)
		
		@grpCaracPhys.setLayout(dispoCaracPhys)
	end
	
	def fillCmbSexe()
		@cmbSexe.addItem(tr(''))
		
		listeSexes = $manuel.getSexesList
		
		for sexe in listeSexes
			@cmbSexe.addItem(sexe)
		end
	end
	
	def fillCmbAlignment()
		@cmbAlignment.addItem(tr(''))
		
		listeAlign = $manuel.getAlignementsList
		
		for align in listeAlign
			@cmbAlignment.addItem(align)
		end
	end
	
	def fillCmbRace()
		@cmbRace.addItem(tr(''))
		
		listeRaces = $manuel.getRacesList
		
		for race in listeRaces
			@cmbRace.addItem(race)
		end
	end
	
	def fillCmbCheveux()
		@cmbCheveux.addItem(tr(''))
		
		listeCheveux = $manuel.getCheveuxList
		
		for cheveux in listeCheveux
			@cmbCheveux.addItem(cheveux)
		end
	end
	
	def fillCmbYeux()
		@cmbYeux.addItem(tr(''))
		
		listeYeux = $manuel.getYeuxList
		
		for yeux in listeYeux
			@cmbYeux.addItem(yeux)
		end
	end
	
	def validateStep()
		message = 'Les erreurs suivantes furent repérées :' + "\n"
		erreur = false
		
		if @lneNomPerso.text == '' # Le nom de personnage est vide.
			erreur = true
			message += "\n" + '-Le nom de personnage ne peut être vide.'
		end
		
		if @cmbSexe.currentIndex == 0 # Le sexe du personnage est vide.
			erreur = true
			message += "\n" + '-Le sexe n\'est pas choisi.'
		end
		
		if @cmbAlignment.currentIndex == 0 # L'alignement du personnage est vide.
			erreur = true
			message += "\n" + '-L\'alignement n\'est pas choisi.'
		end
		
		if @cmbRace.currentIndex == 0 # La race du personnage est vide.
			erreur = true
			message += "\n" + '-La race n\'est pas choisie.'
		end
		
		if @cmbCheveux.currentIndex == 0 # La couleur de cheveux est vide.
			erreur = true
			message += "\n" + '-La couleur de cheveux n\'est pas choisie.'
		end
		
		if @cmbYeux.currentIndex == 0 # La couleur d'yeux est vide.
			erreur = true
			message += "\n" + '-La couleur d\'yeux n\'est pas choisie.'
		end
		
		if @lneAge.text == '' # L'âge est vide.
			erreur = true
			message += "\n" + '-L\'âge du personnage ne peut être vide.'
		end
		
		if @lneTaille.text == '' # La taille est vide.
			erreur = true
			message += "\n" + '-La taille du personnage ne peut être vide.'
		end
		
		if @lnePoids.text == '' # Le poids est vide.
			erreur = true
			message += "\n" + '-Le poids du personnage ne peut être vide.'
		end
		
		if erreur
			MessageOk.new(message)
			return false
		else
			return true
		end
	end
	
	def changing()
		if changed?()
			@@nom = @lneNomPerso.text()
			@@sexe = @cmbSexe.currentIndex()
			@@race = @cmbRace.currentIndex()
			@@alignment = @cmbAlignment.currentIndex()
			
			@@cheveux = @cmbCheveux.currentIndex()
			@@yeux = @cmbYeux.currentIndex()
			@@age = @lneAge.text()
			@@poids = @lnePoids.text()
			@@taille = @lneTaille.text()
			
			if $DEBUG
				puts '------SAVING------'
				puts 'NOM : ' + @@nom.to_s
				puts 'SEXE : ' + @@sexe.to_s
				puts 'RACE : ' + @@race.to_s
				puts 'ALIGN : ' + @@alignment.to_s
			end
			
			@@classe = 0
	
			@@carac = Array.new()
			
			@@compClasse = Array.new()
			@@compHClasse = Array.new()
			
			@@sorts = Array.new()
			
			@@dons = Array.new()
		end
	end
	
	def changed?()
		if @@nom != @lneNomPerso.text()
			return true
		end
		if @@sexe != @cmbSexe.currentIndex()
			return true
		end
		if @@race != @cmbRace.currentIndex()
			return true
		end
		if @@alignment != @cmbAlignment.currentIndex()
			return true
		end
		
		if @@cheveux != @cmbCheveux.currentIndex()
			return true
		end
		if @@yeux != @cmbYeux.currentIndex()
			return true
		end
		if @@age != @lneAge.text()
			return true
		end
		if @@poids != @lnePoids.text()
			return true
		end
		if @@taille != @lneTaille.text()
			return true
		end
		
		return false
	end
end

# Contenu du menu principal
class CreationPerso_Classe < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 2 - La classe ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+50pt;'>Étape 2 - La Classe</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.addWidget(@cmbClasses, 1, 1)
		
		@dispoCorps.addLayout(@grilleInfos, 1, 2, 3, 3)
		@dispoCorps.setAlignment(@grilleInfos, Qt::AlignCenter)
		@dispoCorps.setAlignment(@grilleInfos, Qt::AlignCenter)
		
		@dispoCorps.addWidget(@cmdPlusInfos, 4, 3)
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		#puts @dispoCorps.rowCount().to_s + ", " + @dispoCorps.columnCount().to_s
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 1)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 1)
		end
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		#@cmdNext.setEnabled(false)
	end
	
	def createDataObjects()
		# Étape 2 -----------------------------------
		
		@cmbClasses = Qt::ComboBox.new()
		@cmbClasses.setFixedWidth(120)
		@cmbClasses.setMaxVisibleItems(6)
		fillClassList()
		@cmbClasses.setCurrentIndex(@@classe)
		
		@grilleInfos = Qt::GridLayout.new()
		lblTest = Qt::Label.new('TESTING')
		lblTest.setMinimumSize(400,200)
		lblTest.setPalette(Qt::Palette.new(MANUAL_COLOR))
		lblTest.setAutoFillBackground(true)
		lblTest.setAlignment(Qt::AlignCenter)
		@grilleInfos.addWidget(lblTest, 0, 0)
		@grilleInfos.setAlignment(lblTest, Qt::AlignCenter)
		
		#@grilleInfos.setSizeConstraint(Qt::GridLayout::SetMinimumSize)
		#infoClasse = Qt::ScrollArea.new()
		
		@cmdPlusInfos = Qt::PushButton.new(tr('Plus d\'information'))
		
	end
	
	def fillClassList()
		@cmbClasses.addItem(tr(''))
		
		listeClasses = $manuel.getClassList
		
		for classe in listeClasses
			@cmbClasses.addItem(classe)
		end
	end
	
	def validateStep()
		if @cmbClasses.currentIndex == 0
			MessageOk.new('Vous devez choisir une classe.')
			return false
		end
		
		return true
	end
	
	def changing()
		if changed?
			@@classe = @cmbClasses.currentIndex
	
			@@carac = Array.new()
			
			@@compClasse = Array.new()
			@@compHClasse = Array.new()
			
			@@sorts = Array.new()
			
			@@dons = Array.new()
		end
	end
	
	def changed?()
		if @@classe != @cmbClasses.currentIndex
			return true
		end
		
		return false
	end
end

class CreationPerso_Attributs < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	slots 'choiceMade()'
	
	# Attributs
	
	def initialize()
		
		#$StatSeed = 2992604569927998574498177809916116233 # Seed à doublons! (10 10 10 11 12 16)
		@refreshing = false
		@was = Array.new
		
		if $StatSeed == nil
			if $DEBUG
				puts 'SEED IS NIL'
			end
			
			srand()
			$StatSeed = srand()
		end
		
		srand($StatSeed)
		
		if $DEBUG
			puts 'SEED : ' + $StatSeed.to_s
		end
		
		total = 0
		@attrArr = Array.new
		
		while total < $manuel.attributs.length * 11
			total = 0
			stat = 0
			
			while stat < $manuel.attributs.length
				@attrArr[stat] = Des.highest(4,6,3)
				total += @attrArr[stat]

				stat += 1
			end
		end
		
		@attrArr.sort!
		@available = @attrArr.dup
		@available.fill(true)
		
		if $DEBUG
			puts '-------------------------------------FINAL STATS'
			puts @attrArr
		end
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 3 - Les attributs ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+50pt;'>Étape 3 - Les Attributs</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.addWidget(@grpStats,1,1)
		
		@dispoCorps.addLayout(@midLayout,2,1)
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 1)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 1)
		end
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		@cmdNext.setEnabled(true)
	end
	
	def createDataObjects # Crée les objets de l'affichage.
		@grpStats = Qt::GroupBox.new()
		@grpStats.setMaximumHeight(40)
		@grpStats.setFixedWidth(300)
		grpLayout = Qt::HBoxLayout.new()
		
		@midLayout = Qt::GridLayout.new()
		#@midLayout.setAlignment(Qt::AlignCenter)
		
		headLabels = Array.new()
		headLabels.push(Qt::Label.new(tr('Choix')))
		headLabels.push(Qt::Label.new(tr('Valeur')))
		headLabels.push(Qt::Label.new(tr('Modificateur')))
		
		@midLayout.addWidget(headLabels[0], 0, 0)
		@midLayout.addWidget(headLabels[1], 0, 2)
		@midLayout.addWidget(headLabels[2], 0, 3)
		
		@midLayout.setAlignment(headLabels[0], Qt::AlignLeft)
		@midLayout.setAlignment(headLabels[1], Qt::AlignLeft)
		@midLayout.setAlignment(headLabels[2], Qt::AlignLeft)
		
		# On prépare les valeurs des champs.
		liste = Array.new()
		liste.push('')
		
		for attr in @attrArr
			liste.push(attr.to_s)
		end
		
		# Les étiquettes des attributs dans le groupe.
		@statLabels = Array.new()
		# Les lignes des attributs.
		@lignes = Array.new()
		# Initialisation du compteur.
		stat = 0
		
		# On ajoute les valeurs possible dans l'affichage.
		while stat < $manuel.attributs.length # Pour tous les attributs (étiquettes).
			# On ajoute la valeur de choix à son étiquette.
			@statLabels.push(Qt::Label.new(@attrArr[stat].to_s))
			# On ajoute l'étiquette dans la disposition pour le groupe.
			grpLayout.addWidget(@statLabels.last)
			# Incrémentation du compteur
			stat += 1
		end
		
		# Ré-initialisation du compteur.
		stat = 0
		
		# On ajoute les lignes
		while stat < $manuel.attributs.length # Pour tous les attributs (lignes).
			# On ajoute une ligne
			@lignes.push(AttrLine.new($manuel.attributs[stat], $manuel.races[@@race-1]))
			# On ajoute les choix.
			@lignes.last.changerListe(liste)
			# Connexion du changement à la ligne avec les changements du contenu.
			connect(@lignes.last, SIGNAL('choix()'), self, SLOT('choiceMade()'))
			
			# S'il y a une valeur par défaut, l'appliquer.
			if @@carac[stat] != nil
				@lignes.last.setValeur(@@carac[stat].to_s)
			end
			
			# On ajoute la ligne à la disposition
			@midLayout.addWidget(@lignes.last, @midLayout.rowCount, 0, @midLayout.rowCount, 4)
			# On incrémente le compteur
			stat += 1
		end
		
		# On ajoute la disposition des choix au groupe.
		@grpStats.setLayout(grpLayout)
	end
	
	def validateStep()
		erreur = false
		stat = 0
		message = 'Vous devez choisir une valeur pour les attributs suivants :' + "\n"
		
		while stat < $manuel.attributs.length
			if @lignes[stat].valeurChoisie == nil
				erreur = true
				message += "\n" + $manuel.attributs[stat].txtNomAttribut
			end
			
			stat += 1
		end
		
		if erreur
			MessageOk.new(message)
			return false
		else
			return true
		end
	end
	
	def changing()
		if changed?
			@@carac = Array.new()
			
			for cmb in @lignes
				@@carac.push(cmb.valeurChoisie)
			end
			
			@@compClasse = Array.new()
			@@compHClasse = Array.new()
			
			@@sorts = Array.new()
			
			@@dons = Array.new()
		end
	end
	
	def changingN()
		if validateStep
			changing()
			emit nextStep()
		end
	end
	
	def changed?()
		stat = 0
		
		while stat < $manuel.attributs.length
			if @lignes[stat].valeurChoisie != @@carac[stat]
				return true
			end
			
			stat += 1
		end
		
		return false
	end
	
	def choiceMade()
		if @refreshing # On ne peut changer le choix si nous sommes en train de rafraîchir l'affichage.
			if $DEBUG
				puts 'CHOICE CAN\'T BE MADE : REFRESHING'
			end
			
			return
		end
		
		stat = 0
		
		if $DEBUG
			puts 'CHOICE MADE!'
		end
		
		while stat < $manuel.attributs.length # Pour chaque attribut.
			if $DEBUG
				puts 'LOOK AT ' + stat.to_s
			end
			
			# On prend la valeur choisie en mémoire.
			newIndex = @lignes[stat].valeurChoisie
			
			if newIndex != @was[stat] # On effectue les changements seulement si il y a différence avec l'ancienne valeur.
				if $DEBUG
					puts 'THERE IS A CHANGE! (' + newIndex.to_s + ' from ' + @was[stat].to_s + ')'
				end
				
				if newIndex == nil # On a annulé le choix.
					makeAvailable(@was[stat])
				else # On a changer le choix.
					if @was[stat] == nil # Il n'y avait rien avant.
						makeUnavailable(newIndex)
					else # On prend une nouvelle valeur.
						makeUnavailable(newIndex)
						makeAvailable(@was[stat])
					end
				end
				
				# On actualiser l'ancienne valeur à la nouvelle.
				@was[stat] = newIndex
				refreshCmb()
				# On sort de la boucle.
				break
			end
			
			stat += 1
		end
		
		if $DEBUG
			puts 'NOW AVAILABLE :'
			puts @available
		end
	end
	
	def makeAvailable(value) # Rendre la valeur donnée, étant utilisée, utilisable.
		if $DEBUG
			puts 'MAKING AVAILABLE (' + value.to_s + ')'
		end
		
		arr = Array.new()
		arr.push(@attrArr.index(value))
		id = arr[0]
		
		if $DEBUG
			puts 'id IS ' + id.to_s
		end
		
		arr.push(0)
		
		while @attrArr[arr[0]] == @attrArr[id]
			arr[1] += 1
			id += 1
		end
		
		if $DEBUG
			puts '... UP TO ' + id.to_s + ' (' + arr[1].to_s + ')'
		end
		
		arr.push(0)
		id = arr[0]
		
		while @available[id] && id < arr[0]+arr[1]
			id += 1
		end
		
		@available[id] = true
		
		if $DEBUG
			puts 'CHANGED AT ' + id.to_s
		end
		
		@statLabels[id].setText("<span style='color:black;'>" + @attrArr[id].to_s + "</span>")
	end
	
	def makeUnavailable(value) # Rendre la valeur donnée, étant inutilisée, inutilisable.
		if $DEBUG
			puts 'GONNA MAKE UNAVAILABLE'
		end
		
		arr = Array.new()
		arr.push(@attrArr.index(value))
		id = arr[0]
		
		if $DEBUG
			puts 'id IS ' + id.to_s
		end
		
		arr.push(0)
		
		while @attrArr[arr[0]] == @attrArr[id]
			arr[1] += 1
			id += 1
		end
		
		if $DEBUG
			puts '... UP TO ' + id.to_s + ' (' + arr[1].to_s + ')'
		end
		arr.push(0)
		id = arr[0]
		
		while !@available[id] && id < arr[0]+arr[1]
			id += 1
		end
		
		@available[id] = false
		
		if $DEBUG
			puts 'CHANGED AT ' + id.to_s
		end
		
		@statLabels[id].setText("<span style='color:grey;'>" + @attrArr[id].to_s + "</span>")
	end
	
	def refreshCmb() # Acualisation des valeurs des listes.
		newList = Array.new
		
		if $DEBUG
			puts 'ABOUT TO REFRESH'
			puts 'ADDING EMPTY SPACE TO NEW LIST'
		end
		
		newList.push('')
		attr = 0
		@refreshing = true
		
		while attr < $manuel.attributs.length
			if $DEBUG
				puts 'CHECKING ' + @attrArr[attr].to_s
			end
			
			if @available[attr]
				if $DEBUG
					puts 'ADDING ' + @attrArr[attr].to_s
				end
				
				newList.push(@attrArr[attr].to_s)
			end
			
			attr += 1
		end
		
		cmb = 0
		
		if $DEBUG
			puts '--ABOUT TO CHANGE COMBO BOXES--'
		end
		
		while cmb < $manuel.attributs.length
			begin
				@lignes[cmb].changerListe(newList)
			rescue
				if $DEBUG
					puts 'LINE ' + cmb.to_s + ' DOESN\'T EXIST RIGHT NOW.'
				end
			end
			
			cmb += 1
		end
		
		@refreshing = false
	end
end

class CreationPerso_Competences < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 3 - Les attributs ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+45pt;'>Étape 4 - Les Compétences</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 1)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 1)
		end
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		@cmdNext.setEnabled(true)
	end
	
	def createDataObjects()
		
		
		
	end
	
	def validateStep()
		return true
	end
	
	def changing()
		if changed?
			@@compClasse = Array.new()
			@@compHClasse = Array.new()
			
			@@sorts = Array.new()
			
			@@dons = Array.new()
		end
	end
	
	def changed?()
		
		return false
	end
end

class CreationPerso_Sorts < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 5 - Les sorts ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+50pt;'>Étape 5 - Les Sorts</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 1)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 1)
		end
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		@cmdNext.setEnabled(true)
	end
	
	def createDataObjects()
		
		
		
	end
	
	def validateStep()
		return true
	end
	
	def changing()
		if changed?
			@@sorts = Array.new()
			
			@@dons = Array.new()
		end
	end
	
	def changed?()
		
		return false
	end
end

class CreationPerso_Dons < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 6 - Les dons ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+50pt;'>Étape 6 - Les Dons</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 1)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 1)
		end
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		@cmdNext.setEnabled(true)
	end
	
	def createDataObjects()
		
		
		
	end
	
	def validateStep()
		return true
	end
	
	def changing()
		if changed?
			@@dons = Array.new()
		end
	end
	
	def changed?()
		
		return false
	end
end

class CreationPerso_Infos < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 7 - Information Supplémentaires ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+30pt;'>Étape 7 - Informations Supplémentaires</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		teteCaractere = Qt::Label.new(tr('Caractère'))
		teteHistoire = Qt::Label.new(tr('Histoire'))
		
		@dispoCorps.addWidget(teteCaractere, 1, 1)
		@dispoCorps.setAlignment(teteCaractere, Qt::AlignCenter)
		
		@dispoCorps.addWidget(teteHistoire, 1, 3)
		@dispoCorps.setAlignment(teteHistoire, Qt::AlignCenter)
		
		@dispoCorps.addWidget(@caractere, 2, 1)
		@dispoCorps.setAlignment(@caractere, Qt::AlignCenter)
		
		@dispoCorps.addWidget(@histoire, 2, 3)
		@dispoCorps.setAlignment(@histoire, Qt::AlignCenter)
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 0)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 0)
		end
		
		@dispoCorps.setColumnStretch(2, 1)
		@dispoCorps.setRowStretch(2, 1)
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
	end
	
	def createDataObjects()
		@caractere = Qt::TextEdit.new()
		@histoire = Qt::TextEdit.new()
		
		@caractere.setMinimumSize(300,300)
		@histoire.setMinimumSize(300,300)
		
		@caractere.setAcceptRichText(false)
		@histoire.setAcceptRichText(false)
		
		@caractere.setPlainText(@@caractere)
		@histoire.setPlainText(@@histoire)
		
		@caractere.setWordWrapMode(4)
		@histoire.setWordWrapMode(4)
		
		@caractere.setUndoRedoEnabled(true)
		@histoire.setUndoRedoEnabled(true)
		
		#@caractere.setCanPaste(true)
		#@histoire.setCanPaste(true)
	end
	
	def validateStep()
		return true
	end
	
	def changing()
		@@caractere = @caractere.toPlainText()
		@@histoire = @histoire.toPlainText()
	end
end

class CreationPerso_Resume < CreationPerso
	# Flux
	#signals 'previous()', 'next()'
	
	# Attributs
	
	def initialize()
		
		super
	end
	
	# Crée les écrans du menu
	def createScreens()
		super
		# Créations des contrôles
		createDataObjects()
		
		# --- Étape 7 - Information Supplémentaires ---
		
		# Titre
		txtTitreClasse = tr("<span style='font-size:+40pt;'>Étape 8 - Confirmer les choix</span>")
		@lblTitre.setText(txtTitreClasse)
		
		# Corps de texte
		@dispoCorps = Qt::GridLayout.new()
		
		@dispoCorps.addWidget(@corps, 1, 1)
		
		@dispoCorps.setRowStretch(0, 1)
		@dispoCorps.setRowMinimumHeight(0, 75)
		
		@dispoCorps.setRowStretch(@dispoCorps.rowCount(), 3)
		@dispoCorps.setRowMinimumHeight(@dispoCorps.rowCount()-1, 75)
		
		@dispoCorps.setColumnStretch(0, 1)
		@dispoCorps.setColumnMinimumWidth(0, 75)
		
		@dispoCorps.setColumnStretch(@dispoCorps.columnCount(), 1)
		@dispoCorps.setColumnMinimumWidth(@dispoCorps.columnCount()-1, 75)
		
		for i in 1..(@dispoCorps.rowCount()-2)
			@dispoCorps.setRowStretch(i, 0)
		end
		
		for i in 1..(@dispoCorps.columnCount()-2)
			@dispoCorps.setColumnStretch(i, 0)
		end
		
		@dispoCorps.setColumnStretch(2, 1)
		@dispoCorps.setRowStretch(2, 1)
		
		@mainScreen.insertItem(1, @dispoCorps)
		@mainScreen.setStretchFactor(@dispoCorps, 1)
		
		@cmdNext.setText(tr('Confirmer'))
		@cmdNext.setEnabled(false)
	end
	
	def createDataObjects()
		personnage = Personnage.new(0,
									$manuel.sexes[@@sexe-1],
									$manuel.races[@@race-1],
									@@nom,
									$manuel.cheveux[@@cheveux-1],
									$manuel.yeux[@@yeux-1],
									@@taille.to_i,
									@@poids.to_i,
									@@age.to_i,
									$manuel.alignements[@@alignment-1],
									0,
									0,
									0,
									@@histoire,
									@@caractere,
									'')
		personnage.setAttrib(@@carac)
		personnage.ajoutClasse($manuel.classes[@@classe-1])
		@corps = personnage.previsualiser
	end
	
	def validateStep()
		return true
	end
	
	def changing()
	end
end

# Contenu de l'accueil du manuel
class AccueilManuel < Contenu
	attr_reader :mainScreen # Écran d'affichage principal
	
	def initialize()
		super
	end
	
	# Crée les écrans du menu
	def createScreens
		# --- Écran Principal ---
		
		
		# Titre
		
		
		# Corps de texte
		
		
		# Assemblage des éléments
		
	end
end