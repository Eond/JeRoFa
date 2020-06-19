# #######################################################################
# 
# Contient différents Widgets pour simplifier le travail.
# 
# #######################################################################

# Contient les informations d'une ligne dans la création de personnage pour choisir et afficher les attributs.
class AttrLine < Qt::Widget
	# Flux
	signals 'choix()'
	slots 'actualiser()'
	
	def initialize(attribut, race)
		super()
		
		@attribut        = attribut                   # Attribut de la ligne.
		@race            = race                       # Race du personnage.
		@cmbChoix        = Qt::ComboBox.new()         # Boîte défilante pour le choix des attributs.
		strAttribut      = @attribut.txtNomAttribut   # Chaîne pour l'étiquette du nom de l'attribut.
		@lblAttribut     = Qt::Label.new(strAttribut) # Étiquette du nom de l'attribut.
		@lblValeur       = Qt::Label.new('99')        # Étiquette de la valeur finale de l'attribut.
		@lblModificateur = Qt::Label.new('+0')        # Étiquette de la valeur du modificateur de l'attribut.
		
		# Dimension des Widgets
		@cmbChoix.setFixedHeight(20)
		@lblAttribut.setFixedHeight(20)
		@lblValeur.setFixedHeight(20)
		@lblModificateur.setFixedHeight(20)
		
		@cmbChoix.setMinimumWidth(       50)
		@lblAttribut.setMinimumWidth(    175)
		@lblValeur.setMinimumWidth(      100)
		@lblModificateur.setMinimumWidth(100)
		
		# Valeur vide dans la boîte défilante.
		@cmbChoix.addItem('')
		@cmbChoix.setCurrentIndex(0)
		
		# Disposition des Widgets
		layout = Qt::HBoxLayout.new()
		
		layout.addWidget(@cmbChoix)        # Boîte défilante des choix possibles.
		layout.addWidget(@lblAttribut)     # Nom de l'attribut.
		layout.addWidget(@lblValeur)       # Valeur finale de l'attribut.
		layout.addWidget(@lblModificateur) # Modificateur de l'attribut.
		
		# Alignement des Widgets.
		layout.setAlignment(@cmbChoix, Qt::AlignVCenter + Qt::AlignLeft)
		layout.setAlignment(@lblAttribut, Qt::AlignVCenter + Qt::AlignRight)
		layout.setAlignment(@lblValeur, Qt::AlignCenter)
		layout.setAlignment(@lblModificateur, Qt::AlignCenter)
		
		setLayout(layout) # Application de la disposition
		
		# Connecter le choix de la boîte défilante au signal du choix.
		connect(@cmbChoix, SIGNAL('currentIndexChanged(int)'), self, SIGNAL('choix()'))
		# Connecter le signal du choix à l'actualisation des Widgets.
		connect(self, SIGNAL('choix()'), self, SLOT('actualiser()'))
	end
	
	def actualiser # On met à jour la valeur et le modificateur
		choix = @cmbChoix.currentText # Acquisition de la valeur du choix
		
		if choix == '' # Le choix fut retiré, il n'y a plus de valeur.
			# On vide la valeur finale.
			@lblValeur.setText('')
			# On vide le modificateur.
			@lblModificateur.setText('')
		else # Une nouvelle valeur fut choisie.
			# On prend ce choix.
			choix = choix.to_i
			
			bonus = 0
			# On prend le modificateur de race pour cet attribut.
			if @race != nil
				mods = @race.modAttrib
				
				for attrib in mods
					if attrib[0].to_i == @attribut.intIDAttribut.to_i
						bonus = attrib[1].to_i
					end
				end
			end
			# On ajoute le bonus au choix.
			choix += bonus.to_i
			# On affiche la valeur finale.
			@lblValeur.setText(choix.to_s)
			# On calcule le modificateur
			modif = ((choix-10)/2).round
			# On prépare le préfixe (signe de la valeur numérique).
			prefix = '+'
			
			if modif < 0 # Le nombre est négatif.
				prefix = '-'
			end
			
			# On affiche le modificateur.
			@lblModificateur.setText(prefix + modif.abs.to_s)
		end
	end
	
	def changerListe(listeValeurs) # On change les valeurs du choix pour la nouvelle liste.
		# On initialise une nouvelle variable pour ne pas changer directement les données externes.
		listValeurs = listeValeurs.dup
		# On prend la valeur présente du choix.
		ownValue = @cmbChoix.currentText
		
		if $DEBUG
			puts 'CHECKING OWN VALUE'
		end
		
		if ownValue != '' #  La valeur est bonne, on peut la garder.
			if $DEBUG
				puts 'OWN VALUE IS GOOD (' + ownValue.to_s + ')'
			end
			
			# On ajoute la valeur à la liste.
			listValeurs.push(ownValue.to_s)
		end
		
		# On trie la liste.
		listValeurs.sort!
		# On initialise le compteur pour effacer les anciens choix.
		idItem = @cmbChoix.count
		
		if $DEBUG
			puts 'COMBO BOX HAS ' + idItem.to_s + ' ITEMS.'
		end
		
		while idItem >= 0
			# On enlève un choix
			@cmbChoix.removeItem(idItem)
			idItem -= 1
		end
		
		if $DEBUG
			puts 'COMBO BOX NOW HAS ' + @cmbChoix.count.to_s + ' ITEMS.'
			puts 'NOW ADDING NEW ITEMS'
		end
		
		# On initialise un booléen pour mettre la valeur par défaut.
		currentSet = false
		
		# On ajoute chaque objet de la liste.
		for value in 0..(listValeurs.length-1)
			if $DEBUG
				puts 'ADDING "' + listValeurs[value].to_s + '"'
			end
			
			# Ajout d'un objet.
			@cmbChoix.addItem(listValeurs[value].to_s)
				
			if !currentSet && listValeurs[value].to_i == ownValue.to_i && ownValue.to_i != 0 # La valeur qu'on vient d'ajouter est la même que la valeur choix avant.
				if $DEBUG
					puts '--ITEM IS OWN VALUE'
				end
				
				# On indique que le choix par défaut est pris.
				currentSet = true
				# On change le choix dans la boîte défilante.
				@cmbChoix.setCurrentIndex(value)
			end
		end
		
		if !currentSet # Le choix par défaut n'a pas été définit.
			if $DEBUG
				puts 'PUTTING DEFAULT VALUE'
			end
			
			# On change le choix pour la valeur vide.
			@cmbChoix.setCurrentIndex(0)
		end
	end
	
	def valeurChoisie # Retourne la valeur choisie en chaîne.
		# Acquisition de la valeur.
		begin
			valeur = @cmbChoix.currentText
		rescue
			valeur = ''
		end
		
		if valeur == '' # Aucune valeur choisie.
			valeur = nil
		else # Valeur choisie.
			valeur = valeur.to_i
		end
		
		return valeur
	end
	
	def setValeur(strChoix) # On force le choix.
		# Initialisation du compteur.
		idIndex = 0
		
		# Boucle pour trouver la valeur.
		while idIndex < @cmbChoix.count
			if @cmbChoix.itemText(idIndex) == strChoix.to_s # La valeur est trouvée.
				# On applique la valeur à la boîte défilante.
				@cmbChoix.setCurrentIndex(idIndex)
				# On quitte la méthode.
				return
			end
			
			# Incrémentation du compteur
			idIndex += 1
		end
		
		# Aucune valeur trouvée : on ne change rien.
	end
	
	def getSaveTable # Retourne les informations dans un format pour créer un Personnage
		return [@attribut.intIDAttribut, @cmbChoix.currentText.to_i]
	end
end

# Affiche les informations d'un personnage
class ResumePerso < Qt::Widget
	
	def initialize(personnage)
		super()
		@affichage = Qt::GridLayout.new()
		
		@affichage.addWidget(Qt::Label.new('Nom : '), 0, 0)
		@affichage.addWidget(Qt::Label.new('Race : '), 1, 0)
		@affichage.addWidget(Qt::Label.new('Alignement : '), 2, 0)
		@affichage.addWidget(Qt::Label.new('Sexe : '), 3, 0)
		@affichage.addWidget(Qt::Label.new('Classe(s) : '), 4, 0)
		
		@affichage.addWidget(Qt::Label.new(personnage.txtNomPersonnage), 0, 1)
		@affichage.addWidget(Qt::Label.new(personnage.race.txtNomRace), 1, 1)
		@affichage.addWidget(Qt::Label.new(personnage.alignement.txtAlignement), 2, 1)
		@affichage.addWidget(Qt::Label.new(personnage.sexe.txtNomSexe), 3, 1)
		
		classes = ''
		
		for classe in personnage.classes
			classes += '  ' + classe.txtNomClasse + ' ' + classe.intNiveau.to_s
		end
		
		@affichage.addWidget(Qt::Label.new(classes), 4, 1)
		
		@affichage.addWidget(Qt::Label.new('Histoire : '), 5, 0)
		@affichage.addWidget(Qt::Label.new(personnage.memHistoire), 5, 1)
		
		@affichage.addWidget(Qt::Label.new('Caractère : '), 6, 0)
		@affichage.addWidget(Qt::Label.new(personnage.memPsychologie), 6, 1)
		
		attributs = ''
		mods = personnage.race.modAttrib
		
		for attribut in personnage.attrib
			bonusRace = 0
		
			for attrib in mods
				if attrib[0].to_i == attribut.intIDAttribut.to_i
					bonusRace = attrib[1].to_i
				end
			end
			
			if bonusRace != 0
				attributs += attribut.txtAbbrAttribut + ' ' + (attribut.intValeur + bonusRace).to_s + ' (' + attribut.intValeur.to_s
				
				if bonusRace > 0
					attributs += '+'
				else
					attributs += '-'
				end
				
				attributs += bonusRace.abs.to_s + '(racial))' + "\n"
				
			else
				attributs += attribut.txtAbbrAttribut + ' ' + attribut.intValeur.to_s + "\n"
			end
		end
		
		@affichage.addWidget(Qt::Label.new(attributs), 7, 0, 7, 1)
		
		setLayout(@affichage)
	end
end