# #######################################################################
# 
# Contient les classes Métiers 
# 
# #######################################################################
class Race
	attr_reader :intIDRace
	attr_reader :grandeur
	attr_reader :intAgeMax
	attr_reader :intAjustementNiveau
	attr_reader :blnJouable
	attr_reader :txtNomRace
	attr_reader :memDescription
	attr_reader :modAttrib
	attr_reader :modSkill
	attr_reader :blnmodiff
	
	def initialize(intIDRace,grandeur,intAgeMax,intAjustementNiveau,blnJouable,txtNomRace,memDescription)
		@intIDRace = intIDRace
		@grandeur = grandeur
		@intAgeMax = intAgeMax
		@intAjustementNiveau = intAjustementNiveau
		@blnJouable = blnJouable
		@txtNomRace = txtNomRace
		@memDescription = memDescription
		@modAttrib = getModAttrib()
		@modSkill = getModSkill()
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return 'IDRace = ' + intIDRace.to_s + "\n" + 'Nom de la race: ' + txtNomRace + "\n" + 'Age Max: ' + intAgeMax.to_s  + "\n" + 'Ajustement Niveau : ' + intAjustementNiveau.to_s  + "\n" + 'Grandeur : ' + @grandeur.txtNomGrandeur + "\n\n"
	end
	def getModAttrib()
		str = Array.new
		str = $bd.select('*','tblybonusattributs','intIDRace = ' + @intIDRace.to_s)
		ret = Array.new(Array.new)
		
		for a in str
			ret.push([a[1], a[2]])
			#puts 'RET (FOR ' + @intIDRace.to_s + ')'
			#puts ret.last
		end
		return ret
	end
	def getModSkill()
		skr = Array.new
		skr = $bd.select('*','tblybonuscompetences','intIDRace = ' + @intIDRace.to_s)
		ski = Array.new(Array.new)
		for b in skr
			ski.push([b[1], b[2]])
			#puts 'SKI(FOR ' + @intIDRace.to_s + ')'
			#puts ski.last
		end 
	end
end
class Alignement
	attr_reader :intIDAlignement
	attr_reader :txtAlignement
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDAlignement,txtAlignement,memDescription)
		@intIDAlignement = intIDAlignement
		@txtAlignement = txtAlignement
		@memDescription = memDescription
		@blnmodiff = false
	end
	
	def show()# méthode se combinant avec puts pour les tests
		return intIDAlignement.to_s + ' - ' + txtAlignement
	end
end
class Sexe
	attr_reader :intIDSexe
	attr_reader :txtNomSexe
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDSexe,txtNomSexe,memDescription)
		@intIDSexe = intIDSexe
		@txtNomSexe = txtNomSexe
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDSexe.to_s + ' - ' + txtNomSexe
	end

end
class Grandeur
	attr_reader :intIDGrandeur
	attr_reader :txtNomGrandeur
	attr_reader :intNumeroGrandeur
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDGrandeur,txtNomGrandeur,intNumeroGrandeur,memDescription)
	@intIDGrandeur = intIDGrandeur
	@txtNomGrandeur = txtNomGrandeur
	@intNumeroGrandeur = intNumeroGrandeur
	@memDescription = memDescription
	@blnmodiff = false
	end
	
	def show()# méthode se combinant avec puts pour les tests
		return intIDGrandeur.to_s + ' - ' + txtNomGrandeur + ' - ' + intNumeroGrandeur.to_s
	end
end
class Cheveux
	attr_reader :intIDCheveux
	attr_reader :txtNomCheveux
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDCheveux,txtNomCheveux,memDescription)
		@intIDCheveux = intIDCheveux
		@txtNomCheveux = txtNomCheveux
		@memDescription = memDescription
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDCheveux.to_s + ' - ' + txtNomCheveux 
	end
	def listeRaceCheveux(idrace)
	
	end
	def listeCheveux()
	end
end
class EtapeAge
	attr_reader :intIDEtapeAge
	attr_reader :txtNomEtapeAge
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDEtapeAge,txtNomEtapeAge,memDescription)
		@intIDEtapeAge = intIDEtapeAge
		@txtNomEtapeAge = txtNomEtapeAge
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDEtapeAge.to_s + ' - ' + txtNomEtapeAge
	end
end
class TypeObjet
	attr_reader :intIDTypeObjet
	attr_reader :txtNomTypeObjet
	attr_reader :blnConteneur
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDTypeObjet, txtNomTypeObjet, blnConteneur, memDescription)
		@intIDTypeObjet = intIDTypeObjet
		@txtNomTypeObjet = txtNomTypeObjet
		@blnConteneur = blnConteneur
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeObjet.to_s + ' - ' + txtNomTypeObjet
	end
end
class Cible
	attr_reader :intIDCible
	attr_reader :txtNomCible
	attr_reader :intArgNum
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDCible, txtNomCible, intArgNum, memDescription)
		@intIDCible = intIDCible
		@txtNomCible = txtNomCible
		@intArgNum = intArgNum
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDCible.to_s + ' - ' + txtNomCible + ' - ' + intArgNum.to_s
	end
end
class TypeRace
	attr_reader :intIDTypeRace
	attr_reader :txtNomTypeRace
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDTypeRace, txtNomTypeRace, memDescription)
		@intIDTypeRace = intIDTypeRace
		@txtNomTypeRace = txtNomTypeRace
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeRace.to_s + ' - ' + txtNomTypeRace
	end
end
class Alphabet
	attr_reader :intIDAlphabet
	attr_reader :txtNomAlphabet
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDAlphabet, txtNomAlphabet, memDescription)
		@intIDAlphabet = intIDAlphabet
		@txtNomAlphabet = txtNomAlphabet
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDAlphabet.to_s + ' - ' + txtNomAlphabet
	end
end
class Langue
	attr_reader :intIDLangue
	attr_reader :txtNomLangue
	attr_reader :alphabet
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDLangue, txtNomLangue, alphabet, memDescription)
		@intIDLangue = intIDLangue
		@txtNomLangue = txtNomLangue
		@alphabet = alphabet
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDLangue.to_s + ' - ' + txtNomLangue + ' - ' + @alphabet.txtNomAlphabet
	end
	def listeLangues()
	
	end
end
class Yeux
	attr_reader :intIDYeux
	attr_reader :txtNomYeux
	attr_reader :blnmodiff
	def initialize(intIDYeux, txtNomYeux)
		@intIDYeux = intIDYeux
		@txtNomYeux = txtNomYeux
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDYeux.to_s + ' - ' + txtNomYeux
	end
	def listeRace(idrace)
		
	end
end
class TempsUtilisation
	attr_reader :intIDTempsUtilisation
	attr_reader :txtNomUtilisation
	attr_reader :intTempsUtilisation
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDTempsUtilisation, txtNomUtilisation, intTempsUtilisation, memDescription)
		@intIDTempsUtilisation = intIDTempsUtilisation
		@txtNomUtilisation = txtNomUtilisation
		@intTempsUtilisation = intTempsUtilisation
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTempsUtilisation.to_s + ' - ' + txtNomUtilisation + ' - ' + intTempsUtilisation.to_s
	end
end
class Duree
	attr_reader :intIDDuree
	attr_reader :txtDuree
	attr_reader :intCodeDuree
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDDuree, txtDuree, intCodeDuree, memDescription)
		@intIDDuree = intIDDuree
		@txtDuree = txtDuree
		@intCodeDuree = intCodeDuree
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDDuree.to_s + ' - ' + txtDuree + ' - ' + intCodeDuree.to_s
	end
end
class Objet
	attr_reader :intIDObjet
	attr_reader :txtNomObjet
	attr_reader :intDurabilite
	attr_reader :intDurete
	attr_reader :intPoids
	attr_reader :intTaille
	attr_reader :tempsUtilisation
	attr_reader :duree
	attr_reader :grandeur
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDObjet,grandeur, tempsUtilisation, duree, intDurabilite, intDurete, intPoids, intTaille, txtNomObjet, memDescription)
		@intIDObjet = intIDObjet
		@txtNomObjet = txtNomObjet
		@intDurabilite = intDurabilite
		@intDurete = intDurete
		@intPoids = intPoids
		@intTaille = intTaille
		@tempsUtilisation = tempsUtilisation
		@duree = duree
		@grandeur = grandeur
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return @intIDObjet.to_s + ' - ' + @txtNomObjet
	end
end
class Portee
	attr_reader :intIDPortee
	attr_reader :txtNomPortee
	attr_reader :intDistance
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDPortee, txtNomPortee, intDistance, memDescription)
		@intIDPortee = intIDPortee
		@txtNomPortee = txtNomPortee
		@intDistance = intDistance
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDPortee.to_s + ' - ' + txtNomPortee + ' - ' + intDistance.to_s
	end
end
class TypeEffet
	attr_reader :intIDTypeEffet
	attr_reader :txtNomTypeEffet
	attr_reader :intNbArguments
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypeEffet, txtNomTypeEffet, intNbArguments, memDescription)
		@intIDTypeEffet = intIDTypeEffet
		@txtNomTypeEffet = txtNomTypeEffet
		@intNbArguments = intNbArguments
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeEffet.to_s + ' - ' + txtNomTypeEffet + ' - ' + intNbArguments.to_s
	end
end
class TypeSort
	attr_reader :intIDTypeSort
	attr_reader :txtNomTypeSort
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypeSort, txtNomTypeSort, memDescription)
		@intIDTypeSort = intIDTypeSort
		@txtNomTypeSort = txtNomTypeSort
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeSort.to_s + ' - ' + txtNomTypeSort
	end
end
class Composante
	attr_reader :intIDComposante
	attr_reader :txtNomComposante
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDComposante, txtNomComposante, memDescription)
		@intIDComposante = intIDComposante
		@txtNomComposante = txtNomComposante
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDComposante.to_s + ' - ' + txtNomComposante
	end
end
class EcoleMagie
	attr_reader :intIDEcoleMagie
	attr_reader :txtNomEcoleMagie
	attr_reader :blnEcoleAbandonnable
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDEcoleMagie, txtNomEcoleMagie, blnEcoleAbandonnable, memDescription)
		@intIDEcoleMagie = intIDEcoleMagie
		@txtNomEcoleMagie = txtNomEcoleMagie
		@blnEcoleAbandonnable = blnEcoleAbandonnable
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDEcoleMagie.to_s + ' - ' + txtNomEcoleMagie
	end
	def listeEcoleMagieChoix()
	
	end
	
end
class TypePerso
	attr_reader :intIDTypePerso
	attr_reader :txtNomTypePerso
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypePerso, txtNomTypePerso, memDescription)
		@intIDTypePerso = intIDTypePerso
		@txtIDTypePerso = txtNomTypePerso
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypePerso.to_s + ' - ' + txtNomTypePerso
	end
end
class Domaine
	attr_reader :intIDDomaine
	attr_reader :txtNomDomaine
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDDomaine, txtNomDomaine, memDescription)
		@intIDDomaine = intIDDomaine
		@txtNomDomaine = txtNomDomaine
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDDomaine.to_s + ' - ' + txtNomDomaine
	end
	def listeDomaine()
	
	end
end
class SphereDieu
	attr_reader :intIDSphereDieu
	attr_reader :txtNomSphereDieu
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDSphereDieu, txtNomSphereDieu, memDescription)
		@intIDSphereDieu = intIDSphereDieu
		@txtNomSphereDieu = txtNomSphereDieu
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDSphereDieu.to_s + ' - ' + txtNomSphereDieu
	end
end
class TypeLanceur
	attr_reader :intIDTypeLanceur
	attr_reader :txtNomTypeLanceur
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypeLanceur, txtNomTypeLanceur, memDescription)
		@intIDTypeLanceur = intIDTypeLanceur
		@txtNomTypeLanceur = txtNomTypeLanceur
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeLanceur.to_s + ' - ' + txtNomTypeLanceur
	end
end
class Attribut
	attr_reader :intIDAttribut
	attr_reader :txtNomAttribut
	attr_reader :txtAbbrAttribut
	attr_reader :memDescription
	attr_reader :blnmodiff
	attr_reader :intValeur
	
	def initialize(intIDAttribut, txtNomAttribut, txtAbbrAttribut, memDescription)
		@intIDAttribut = intIDAttribut
		@txtNomAttribut = txtNomAttribut
		@txtAbbrAttribut = txtAbbrAttribut
		@memDescription = memDescription
		@intvaleur = 0
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDAttribut.to_s + ' - ' + txtAbbrAttribut + ' - ' + txtNomAttribut
	end
	def setValeur(valeur)
		@intValeur = valeur
	end

end
class Formule
	attr_reader :intIDFormule
	attr_reader :txtFormule
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDFormule, txtFormule, memDescription)
		@intIDFormule = intIDFormule
		@txtFormule = txtFormule
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDFormule.to_s + ' - ' + txtFormule
	end
end
class Argument
	attr_reader :intIDArgument
	attr_reader :txtArgument
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDArgument, txtArgument, memDescription)
		@intIDArgument = intIDArgument
		@txtArgument = txtArgument
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDArgument.to_s + ' - ' + txtArgument
	end
end
class NiveauSort
	attr_reader :intIDNiveauSort
	attr_reader :intNiveauSort
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDNiveauSort, intNiveauSort, memDescription)
		@intIDNiveauSort = intIDNiveauSort
		@intNiveauSort = intNiveauSort
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDNiveauSort.to_s + ' - ' + intNiveauSort.to_s
	end
	def listeNiveausort()
	
	end
end
class TypePrerequis
	attr_reader :intIDTypePrerequis
	attr_reader :txtNomTypePrerequis
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypePrerequis, txtNomTypePrerequis, memDescription)
		@intIDTypePrerequis = intIDTypePrerequis
		@txtNomTypePrerequis = txtNomTypePrerequis
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypePrerequis.to_s + ' - ' + txtNomTypePrerequis
	end
end
class TypeDon
	attr_reader :intIDTypeDon
	attr_reader :txtNomTypeDon
	attr_reader :blnTypeGeneral
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDTypeDon, txtNomTypeDon, blnTypeGeneral, memDescription)
		@intIDTypeDon = intIDTypeDon
		@txtNomTypeDon = txtNomTypeDon
		@blnTypeGeneral = blnTypeGeneral
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDTypeDon.to_s + ' - ' + txtNomTypeDon
	end
end
class Don
	attr_reader :intIDDon
	attr_reader :txtNomDon
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDDon, txtNomDon, memDescription)
		@intIDDon = intIDDon
		@txtNomDon = txtNomDon
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDDon.to_s + ' - ' + txtNomDon
	end
	def listeDons()
	
	end
	def listedonGuerrier()
	
	end
	def listeMetamagie()
	
	end
	def listeCreationobjets()
	
	end
end
class Competence
	attr_reader :intIDCompetence
	attr_reader :txtNomCompetence
	attr_reader :attribut
	attr_reader :memDescription
	attr_reader :blnmodiff
	def initialize(intIDCompetence, attribut, txtNomCompetence, blnPenaliteArmure, blnInne, memDescription)
		@intIDCompetence = intIDCompetence
		@attribut = attribut
		@txtNomCompetence = txtNomCompetence
		@blnPenaliteArmure = blnPenaliteArmure
		@blnInne = blnInne
		@memDescription = memDescription
		@blnmodiff = false
	end
	def show()# méthode se combinant avec puts pour les tests
		begin
			return @intIDCompetence.to_s + ' - ' + @txtNomCompetence + ' - ' + @attribut.txtAbbrAttribut
		rescue NoMethodError
			return @intIDCompetence.to_s + ' - ' + @txtNomCompetence + ' - NIL'
		end
	end
	def listecompetenceclasse(idClasse)
	
	end
	def listecompetencehclasse(idClasse)
	
	end
	def listecompetence()
	
	end
	
end
class Classe
	attr_reader :intIDClasse
	attr_reader :txtNomClasse
	attr_reader :intDesVie
	attr_reader :intNbCompetences
	attr_reader :memDescription
	attr_reader :blnPerdToutPrerequis
	attr_reader :blnNiveauxContinus
	attr_reader :intNiveau
	attr_reader :blnmodiff
	def initialize(intIDClasse, intDesVie, intNbCompetences, blnPerdToutPrerequis, blnNiveauxContinus, txtNomClasse,  memDescription)
		@intIDClasse = intIDClasse
		@txtNomClasse = txtNomClasse
		@intDesVie = intDesVie
		@intNbCompetences = intNbCompetences
		@memDescription = memDescription
		@blnPerdToutPrerequis = blnPerdToutPrerequis
		@blnNiveauxContinus = blnNiveauxContinus
		@blnmodiff = false
		@intNiveau = 1
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDClasse.to_s + ' - ' + txtNomClasse
	end
	def ajouterNiveau()
		@intNiveau += 1
	end
	#- ajouter un attribut de Niveau qui est forcé à 1 étant donné la création du personnage
end
class Personnage

	attr_reader :intIDPersonnage
	attr_reader :sexe
	attr_reader :race
	attr_reader :txtNomPersonnage
	attr_reader :cheveux
	attr_reader :yeux
	attr_reader :intTaille
	attr_reader :intPoids
	attr_reader :intAge
	attr_reader :alignement
	attr_reader :intPVMax
	attr_reader :intPV
	attr_reader :intExperience
	attr_reader :memHistoire
	attr_reader :memPsychologie
	attr_reader :memNotes
	attr_reader :attrib
	attr_reader :classes
	#----------
	attr_reader :blnmodiff
	
	def initialize(intIDPersonnage, sexe, race, txtNomPersonnage, cheveux, yeux, intTaille, intPoids, intAge, alignement, intPVMax, intPV, intExperience, memHistoire, memPsychologie, memNotes)
		if intIDPersonnage == 0 # vérifie si le personnage est en création
			@blnmodiff = true
			
		else
			@blnmodiff = false
		end
			 
			@intIDPersonnage = intIDPersonnage
			@sexe = sexe
			@race = race
			@txtNomPersonnage = txtNomPersonnage
			@cheveux = cheveux
			@yeux = yeux
			@intTaille = intTaille
			@intPoids = intPoids
			@intAge = intAge
			@alignement = alignement
			@intPVMax = intPVMax
			@intPV = intPV
			@intExperience = intExperience
			@memHistoire = memHistoire
			@memPsychologie = memPsychologie
			@memNotes = memNotes		
		if @blnmodiff == false
		 
			#@attrib = attrib fonction qui va chercher les attributs
			#@classes = fontion qui va chercher les classes du personnage et ses niveaux
			
		else
			@attrib = Array.new()
			@classes = Array.new()
		
		end
		# fonction pour aller chercher ses classes ( tableau de classe ) avec leurs niveaux
	end
	
	def getAttrib()
		atts = Array.new
		atts = $bd.select('','','')
	end
	def getClasses()
		clss = Array.new
		clss = $bd.select('','','')
	end
	def setAttrib(att)
		compt = 0
		for valeur in att
			@attrib[compt] = $manuel.attributs[compt].dup
			@attrib[compt].setValeur(valeur)
			compt += 1
		end
	end
	def ajoutClasse(cls)
		flag = false
		for cla in @classes
			if cla.intIDClasse == cls.intIDClasse
				cla.ajouterNiveau
				flag = true
			end
		end
		if !flag
			@classes.push(cls)
		end
	end
	def show()# méthode se combinant avec puts pour les tests
		return intIDPersonnage.to_s + ' - ' + txtNomPersonnage
	end

	def enregistrerPerso()
		#- vérification des ids déjàs utilisés
		findId = Array.new
		findId = $bd.select('*','tblapersonnages','')
		newID = 0
		for id in findId
			if newID < id[0].to_i
				newID = id[0].to_i
			end
		end
		newID += 1
		fields = 'intIDPersonnage, intIDSexe, intIDRace, intIDCheveux, intIDYeux, intIDAlignement, intTaille, intPoids, intAge, intPVMax, intPV, intExperience, txtNomPersonnage, memHistoire, memPsychologie, memNotes'
		values = [newID.to_s + ', ' + @sexe.intIDSexe.to_s + ', ' + @race.intIDRace.to_s + ', ' +'\'' + @txtNomPersonnage + '\', ' + @cheveux.intIDCheveux.to_s + ', ' + @yeux.intIDYeux.to_s + ', ' + @intTaille.to_s + ', ' + @intPoids.to_s + ', '+ @intAge.to_s + ', ' + @alignement.intIDAlignement.to_s + ', ' + @intPVMax.to_s + ', ' + @intPV.to_s + ', ' + @intExperience.to_s + ', \'' + @memHistoire + '\' ,' + @memPsychologie + '\' ,' + @memNotes + '\''  ]
		$bd.insert(true,'tblapersonnages',fields,values)
		
		fields = 'intIDPersonnage, intIDAttribut, intAttribut'
		table = 'tblyattributsperso'
		
		for att in attrib
			
			values = [newID + ', ' + att[0].intIDAttribut.to_s + ', ' + att[1].to_s]
			$bd.insert(true,table,fields,values)
			
		end
		
		
	end
	
	def previsualiser()
		return ResumePerso.new(self)
	end
end
class Sort
	attr_reader :intIDSort
	attr_reader :txtNomSort
	attr_reader :blnResistMagique
	attr_reader :tempsUtilisation
	attr_reader :duree
	attr_reader :blnAnnulable
	attr_reader :memDescription
	attr_reader :blnmodiff
	
	def initialize(intIDSort, tempsUtilisation, duree, blnAnnulable,  blnResistMagique, txtNomSort, memDescription)
		@intIDSort = intIDSort
		@txtNomSort = txtNomSort
		@blnResistMagique = blnResistMagique
		@tempsUtilisation = tempsUtilisation
		@duree = duree
		@blnAnnulable = blnAnnulable
		@memDescription = memDescription
		@blnmodiff = false
	end
	def afficherlistefl(ecoleMagie1 , ecoleMagie2 = nil)
	end
	def show()
		return @intIDSort.to_s		+ ' - ' + @txtNomSort
	end 
end
