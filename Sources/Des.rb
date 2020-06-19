# #######################################################################
# 
# Gère les nombres aléatoires
# 
# #######################################################################

# Auteur : Jean-Michel Beauvais
# Date : 2010.12.02

# Historique
# ----------
#
# 2011.03.24 - Jean-Michel Beauvais
# 	Remplacement des $DEBUG par !$COMPILED.

class Des
	private_class_method :new # Interdire la création de dés manuellement
	
	# Attributs de classe
	attr_reader :max # Maximum du dé
	
	# Variables statiques
	@@allDes = Array.new # Table des dés
	@@minimum = 1 # Minimum des roulements
	@@blnMin = true # Indique si le minimum est actif
	
	# Méthodes
	
	def initialize(max)
		@max = max
	end
	
	# Méthodes statiques
	
	def Des.create(newMax)
		# Ajoute un dé au tableau s'il n'existe pas déjà.
		# newMax = Nouveau dés à ajouté (valeur entière)
		
		# Vérifier si la création est désactivée
		if @@allDes.frozen?
			if !$COMPILED 
				logging 'DICE CREATION IS FROZEN : CAN\'T CREATE.'
			end
			
			return
		end
		
		# Vérifier l'existance du dé
		if exist?(newMax) != -1
			if !$COMPILED 
				logging 'DICE EXIST. CAN\'T CREATE IT.'
			end
			
			return
		end
		
		# Ajout du dé
		@@allDes.push(new(newMax))
		
		if !$COMPILED 
			logging 'DICE CREATION IS COMPLETED.'
		end
	end
	
	def Des.roll(rouleDes)
		# Interprète la chaîne de roulement passée en paramètre et renvoie le résultat. Cette fonction est l'accès utilisateur aux roulements.
		# rouleDes = Variable changée en chaîne de caractère qui représente le dé à rouler, combien de fois et avec quel modificateur
		# ---------- FORMATS DE rouleDes
		# Forme 1 : 'X' (La valeur du dés à rouler une seule fois sans modificateurs.)
		# Forme 2 : 'YdX' (Rouler le dés X un nombre de fois égal à Y)
		# Forme 3 : 'YdX+Z' (Rouler le dés X un nombre de fois égal à Y et lui ajouter Z)
		# Forme 4 : 'YdX-Z' (Rouler le dés X un nombre de fois égal à Y et lui retirer Z)
		
		# Variables
		pos = 0 # Position dans la chaîne
		nb = 0 # Nombre de dés à rouler
		valeur = 0 # Valeur du dé à rouler
		modif = 0 # Valeur du modificateur
		blnPositif = true # Signe du modificateur
		
		# S'assurer d'avoir une chaîne
		rouleDes = rouleDes.to_s
		
		if !$COMPILED 
			logging 'ROLL STRING : ' + rouleDes
		end
		
		# Déterminer le nombre de Dés à rouler (ou la valeur du dé à rouler une fois)
		while rouleDes[pos,1] != 'd' && pos < rouleDes.length
			nb = nb*10 + rouleDes[pos, 1].to_i
			pos += 1
		end
		
		# Rouler une fois si on est à la fin de la chaîne
		if pos == rouleDes.length
			if !$COMPILED 
				logging '1dX ROLL (d' + nb.to_s + ')'
			end
			
			return doRoll(nb, 1)
		end
		
		# Déterminer la valeur du dé
		while rouleDes[pos,1] != '+' && rouleDes[pos,1] != '-' && pos < rouleDes.length
			valeur = valeur*10 + rouleDes[pos, 1].to_i
			pos += 1
		end
		
		# Pas de modificateurs si on est à la fin de la chaîne
		if pos == rouleDes.length
			if !$COMPILED 
				logging 'YdX ROLL (' + nb.to_s + 'd' + valeur.to_s + ')'
			end
			
			return doRoll(valeur, nb)
		end
		
		# Le modificateur est négatif si il y a un - à la position actuelle
		if rouleDes[pos,1] == '-'
			if !$COMPILED 
				logging 'NEGATIVE MODIFIER'
			end
			
			blnPositif = false
		end
		
		# Déterminer la valeur du modificateur
		while pos < rouleDes.length
			modif = modif*10 + rouleDes[pos, 1].to_i
			pos += 1
		end
		
		# Donner le signe négatif au modificateur si il y a lieu
		if !blnPositif 
			modif = modif * -1
		end
		
		if !$COMPILED 
			logging 'YdX+Z ROLL (' + nb.to_s + 'd' + valeur.to_s + ' (' + modif.to_s + '))'
		end

		# Effectuer le roulement complet et renvoyer la valeur
		return doRoll(valeur, nb, modif)
	end
	
	def Des.setMinimum(newMin=nil)
		# Détermine le minimum des roulements
		# newMin = Nouvelle valeur minimale. Ommettre pour désactiver le minimum (Désactiver le minimum ne retire pas le minimum).
		
		# Vérifier si le paramètre fut omis
		if newMin == nil 
			if !$COMPILED 
				logging 'MINIMUM DEACTIVATED'
			end
			
			@@blnMin = false
			return
		end
		
		if !$COMPILED 
			logging 'NEW MINIMUM : ' + newMin.to_s
		end
		
		# Activer le minimum
		@@blnMin = true
		# Mettre le nouveau minimum
		@@minimum = [newMin.to_i, 0].max
	end
	
	def Des.minimum
		# Renvoie la valeur du minimum
		if !$COMPILED 
			logging 'RETURNING MINIMUM (' + @@minimum.to_s + ')'
		end
		
		return @@minimum
	end
	
	def Des.highest(nb, valeur, keep)
		# Utilise les paramètres pour garder un certain nombre de roulements en commençant par le plus gros.
		# nb = Nombre de dés à rouler.
		# valeur = Dés à rouler.
		# keep = Nombre de dés à garder.
		
		rollArr = Array.new # Les roulements
		nbRolled = 0 # Nombre de roulements faits
		kept = nb # Nombre de roulements restant à garder
		
		# S'assurer que le nombre de dés à garder ne dépasse pas le nombre de dés lancés.
		keep = [nb, keep].min
		
		# Faire les roulements
		while nbRolled < nb
			rollArr.push(doRoll(valeur.to_i, 1))
			nbRolled += 1
		end
		
		# Trier les roulements
		rollArr.sort!
		total = 0
		
		# Additionner les roulements à garder
		while kept > (nb-keep)
			total += rollArr[kept-1]
			kept -= 1
		end
		
		if !$COMPILED 
			logging 'ROLLS FOR HIGHEST'
			logging rollArr
			logging 'KEEP ' + keep.to_s + ' HIGHEST = ' + total.to_s
		end
		
		# Renvoyer la valeur finale
		return total
	end
	
	def Des.lowest(nb, valeur, keep)
		# Utilise les paramètres pour garder un certain nombre de roulements en commençant par le plus gros.
		# nb = Nombre de dés à rouler.
		# valeur = Dés à rouler.
		# keep = Nombre de dés à garder.
		
		rollArr = Array.new # Les roulements
		nbRolled = 0 # Nombre de roulements faits
		kept = 0 # Nombre de roulements gardés
		
		# S'assurer que le nombre de dés à garder ne dépasse pas le nombre de dés lancés.
		keep = [nb, keep].min
		
		# Faire les roulements
		while nbRolled < nb
			rollArr.push(doRoll(valeur.to_i, 1))
			nbRolled += 1
		end
		
		# Trier les roulements
		rollArr.sort!
		total = 0
		
		# Additionner les roulements à garder
		while kept < (keep)
			total += rollArr[kept]
			kept += 1
		end
		
		if !$COMPILED 
			logging 'ROLLS FOR LOWEST'
			logging rollArr
			logging 'KEEP ' + keep.to_s + ' LOWEST = ' + total.to_s
		end
		
		# Renvoyer la valeur finale
		return total
	end
	
	def Des.freezeCreation
		# Désactive la création des dés et bloque la modification.
		@@allDes.freeze
		
		if !$COMPILED 
			logging 'DICES CREATION IS NOW FROZEN'
		end
	end
	
	def Des.liste
		# Retourne la liste des dés.
		
		# Liste de retour.
		listRetour = Array.new
		
		# Ajouter la valeur des dés.
		for des in @@allDes
			listRetour.push(des.max)
		end
		
		# Trier la liste.
		listRetour.sort!
		
		# Ajouter le caractère 'd' devant les valeurs.
		for id in 0..(listRetour.length-1)
			listRetour[id] = 'd' + listRetour[id].to_s
		end
		
		# Revoie de la liste.
		return listRetour
	end
	
	# Méthodes statiques privées
	
	def Des.doRoll(valeur, nb, modif = 0)
		# Effectue une sélection aléatoire dans un intervale [nb; nb*valeur]+modif. Cette fonction est uniquement accèssible par les autres fonctions de la classe.
		# valeur = Valeur du dé à rouler.
		# nb = Nombre de dés de la valeur indiquée plus haut à rouler.
		# modif = Modificateur du résultat final à renvoyer.
		
		# Acquérir la position du dé dans le tableau.
		leDes = exist?(valeur.to_i)
		
		# Vérifier si le dé fut trouvé.
		if leDes == -1 
			return 0
		end
		
		total = 0 # Résultat avant le modificateur
		roule = 0 # Nombre de roulements faits
		
		# Faire les roulements
		while roule < nb.to_i
			total += rand(@@allDes[leDes].max)+1
			roule += 1
		end
		
		retour = (total + modif.to_i) # Résultat à renvoyer
		
		# Application du minimum
		if @@blnMin 
			retour = [@@minimum, retour].max
		end
		
		if !$COMPILED 
			logging 'ROLLED ' + retour.to_s
		end
		
		# Retour de la valeur
		return retour
	end
	
	def Des.exist?(trouveDes)
		# Cherche le dé passé en paramètre dans la table des dés et retourne l'indice du dés s'il fut trouvé, -1 dans les autres cas.
		# trouveDes = Valeur du dé à trouver
		
		# Passer dans toute la table des dés.
		for i in 0..@@allDes.length
			# Ignorer les valeurs nulles et vérifier la similitude entre le dé dans la table et celui à trouver.
			if @@allDes[i] != nil && @@allDes[i].max == trouveDes.to_i.abs 
				# Le dé existe, on renvoie sa position dans le tableau.
				if !$COMPILED 
					logging 'd' + trouveDes.to_s + ' EXISTS'
				end
				
				return i
			end
		end
		
		# Le dé n'existe pas, on renvoie -1.
		if !$COMPILED 
			logging 'd' + trouveDes.to_s + ' DOESN\'T EXISTS'
		end
		
		return -1
	end
	
	# Déclare les méthodes de classe privées
	private_class_method :doRoll
	private_class_method :exist?
end

if !$COMPILED
	logging '-------------------DICE CLASS-----------------------'
	logging 'CREATING DICES'
end

# Créer les dés
Des.create(100) # d100
Des.create(20)  # d20
Des.create(12)  # d12
Des.create(10)  # d10
Des.create(8)   # d8
Des.create(6)   # d6
Des.create(4)   # d4
Des.create(3)   # d3 (d6/2)
Des.create(2)   # d2 (d4/2)

if !$COMPILED
	logging 'CREATING EXISTING DICE TEST'
	Des.create(20)
	logging 'FREEZING DICES'
end

# Empêcher la création supplémentaire de dés.
Des.freezeCreation

if !$COMPILED
	logging 'CREATING DICE TEST'
	Des.create(20)
end

if !$COMPILED
	srand 1550
	logging 'ROLL TESTS'
	logging 'STANDARD ROLL TEST (4d100-85)'
	Des.roll('4d100-85')
	logging 'HIGHEST ROLL TEST'
	Des.highest(4,6,3)
	logging 'LOWEST ROLL TEST'
	Des.lowest(5,8,2)
	logging 'MINIMUM DEACTIVATION AND ROLL 1d2-5'
	Des.setMinimum
	Des.roll('1d2-5')
	logging 'MINIMUM TO 5 AND ROLL 1d6'
	Des.setMinimum(5)
	Des.roll(6)
	logging 'MINIMUM TO 1 AND GET VALUE'
	Des.setMinimum(1)
	Des.minimum
	
	logging '-------------------DICE CLASS END-----------------------'
end