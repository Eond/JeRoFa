# #######################################################################
# 
# Contient les classes Métiers 
#
# #######################################################################
require 'Classes Métiers/Classes.rb'

class DonneesManuel
		# Les attr_reader de chaques id des objets ainsi que des tableaux de ces même objets
	attr_reader :idRaces
	attr_reader :idGrandeur
	attr_reader :idTempsUtilisation
	attr_reader :idDuree
	attr_reader :idSorts
	attr_reader :idClasses
	attr_reader :idAttributs
	attr_reader :idCompetences
	attr_reader :idObjets
	attr_reader :idSexes
	attr_reader :idAlignements
	attr_reader :idYeux
	attr_reader :idCheveux
	attr_reader :idPersos
	attr_reader :idAlphabets
	attr_reader :idLangues
	attr_reader :idEtapesAge
	attr_reader :idTypesObjets
	attr_reader :idCibles
	attr_reader :idTypesRaces
	attr_reader :idPortees
	attr_reader :idTypesEffets
	attr_reader :idTypesSorts
	attr_reader :idComposantes
	attr_reader :idEcolesMagies
	attr_reader :idTypesPersos
	attr_reader :idDomaines
	attr_reader :idSpheresDieux
	attr_reader :idTypesLanceurs
	attr_reader :idFormules
	attr_reader :idArguments
	attr_reader :idNiveauxSorts
	attr_reader :idTypesPrerequis
	attr_reader :idTypesDons
	
	attr_reader :idDons
	attr_reader :grandeurs
	attr_reader :races
	attr_reader :tempsUtilisation
	attr_reader :duree
	attr_reader :sorts
	attr_reader :classes
	attr_reader :attributs
	attr_reader :competences
	attr_reader :objets
	attr_reader :sexes
	attr_reader :alignements
	attr_reader :yeux
	attr_reader :cheveux
	attr_reader :persos
	attr_reader :alphabets
	attr_reader :langues
	attr_reader :etapesage
	attr_reader :typesobjets
	attr_reader :cibles
	attr_reader :typesraces
	attr_reader :portees
	attr_reader :typeseffets
	attr_reader :typessorts
	attr_reader :composantes
	attr_reader :ecolesmagies
	attr_reader :typespersos
	attr_reader :domaines
	attr_reader :spheresdieux
	attr_reader :typeslanceurs
	attr_reader :formules
	attr_reader :arguments
	attr_reader :niveauxsorts
	attr_reader :typesprerequis
	attr_reader :typesdons
	attr_reader :dons
	
	def initialize()
	#----- tables HASH pour identifier l'id des objets plus facilement
		@idRaces = Hash.new
		@idGrandeur = Hash.new
		@idTempsUtilisation = Hash.new
		@idDuree = Hash.new
		@idSorts = Hash.new
		@idClasses = Hash.new
		@idAttributs = Hash.new
		@idCompetences = Hash.new
		@idObjets = Hash.new
		@idSexes = Hash.new
		@idAlignements = Hash.new
		@idYeux = Hash.new
		@idCheveux = Hash.new
		@idPersos = Hash.new
		@idAlphabets = Hash.new
		@idLangues = Hash.new
		@idEtapesAge = Hash.new
		@idTypesObjets = Hash.new
		@idCibles = Hash.new
		@idTypesRaces = Hash.new
		@idPortees = Hash.new
		@idTypesEffets = Hash.new
		@idTypesSorts = Hash.new
		@idComposantes = Hash.new
		@idEcolesMagies = Hash.new
		@idTypesPersos = Hash.new
		@idDomaines = Hash.new
		@idSpheresDieux = Hash.new
		@idTypesLanceurs = Hash.new
		@idFormules = Hash.new
		@idArguments = Hash.new
		@idNiveauxSorts = Hash.new
		@idTypesPrerequis = Hash.new
		@idTypesDons = Hash.new
		@idDons = Hash.new
		
	#----------- tables ARRAY pour stocker les objets
		@grandeurs = Array.new
		@races = Array.new
		@tempsUtilisation = Array.new
		@duree = Array.new
		@sorts = Array.new
		@classes = Array.new
		@attributs = Array.new
		@competences = Array.new
		@objets = Array.new
		@sexes = Array.new
		@alignements = Array.new
		@yeux = Array.new
		@cheveux = Array.new
		@persos = Array.new
		@alphabets = Array.new
		@langues = Array.new
		@etapesage = Array.new
		@typesobjets = Array.new
		@cibles = Array.new
		@typesraces = Array.new
		@portees = Array.new
		@typeseffets = Array.new
		@typessorts = Array.new
		@composantes = Array.new
		@ecolesmagies = Array.new
		@typespersos = Array.new
		@domaines = Array.new
		@spheresdieux = Array.new
		@typeslanceurs = Array.new
		@formules = Array.new
		@arguments = Array.new
		@niveauxsorts = Array.new
		@typesprerequis = Array.new
		@typesdons = Array.new
		@dons = Array.new
		
		fetchDataJeRoFa()
	end
	def fetchDataJeRoFa() # chargement de la base de donnée complète
		
		if $bd.blnFonctionnel
			loadAllGrandeurs()
			loadAllTempsUtilisation()
			loadAllDuree()
			loadAllAttributs()
			loadAllSexes()
			loadAllAlignements()
			loadAllYeux()
			loadAllCheveux()
			loadAllAlphabet()
			loadAllLangues()
			loadAllEtapesAge()
			loadAllTypeObjets()
			loadAllCibles()
			loadAllTypesRaces()
			loadAllPortees()
			loadAllTypesEffets()
			loadAllTypesSorts()
			loadAllComposantes()
			loadAllEcolesMagie()
			loadAllTypesPersos()
			loadAllDomaines()
			loadAllSpheresDieux()
			loadAllTypesLanceurs()
			loadAllFomules()
			loadAllArguments()
			loadAllNiveauxSorts()
			loadAllTypesPrerequis()
			loadAllTypesDons()
			#loadAllDons()
			loadAllPerso()
			loadAllRaces()
			loadAllObjects()
			loadAllSkills()
		#	loadAllSpells()
			loadAllClass()
		else
			if $qApp == nil
				puts 'La BD n\'a pu être chargée.'
			else
				MessageOk.new('La BD n\'a put être chargée')
			end
		end
	end
	
		#def loadAllSpells()   -- définitions de stats
	#	spls = Array.new      - -tableau recevant les lignes de base de donnée
	#	spls = $bd.select('*','tblasorts','') -- select de la bd retourné dans le tableau
	#	for spl in spls	-- pour chaque lignes dans le tableau 
	#		nom = spl[5] 	-- le nom devient le contenu de la case 5
	#		@idSorts[nom] = spl[0].to_i  --l' id[nom de l'objet] devien l'id( case 0)
	#		@sorts.push(Sort.new(spl[0].to_i,spl[1],spl[2],@tempsUtilisation[spl[3].to_i],@duree[spl[4].to_i],spl[5],spl[6]))-- création de tous les objets en les placant dans les tableaux , usant parfois des objets déjà créés de D'AUTRES tableaux 
	#		if $DEBUG
	#			puts @sorts[@idSorts[nom]].show  -- affichage si mode debug
	#		end
	#	end
#----------------------------------------------------- chargement des données de la BD
	#def loadAllSpells()  # --- fini fonctionnel
	#	spls = Array.new
	#	spls = $bd.select('*','tblasorts','')
	#	for spl in spls
	#		tu = 0
	#		du = 0
	#		puts 'GONNA PUT SPELLS TU'
	#		while @tempsUtilisation[tu].intIDTempsUtilisation != spl[3].to_i
	###			puts @tempsUtilisation[tu].intIDTempsUtilisation.to_s + ' AND ' + spl[3]
	#			tu +=1
	#		end
	#		while @duree[du].intIDDuree != obj[4].to_i
	#			du +=1
	#		end
	#		nom = spl[5]
	#		@idSorts[nom] = spl[0].to_i
	#		@sorts.push(Sort.new(spl[0].to_i,spl[1],spl[2],@tempsUtilisation[tu],@duree[du],spl[5],spl[6]))
	#		if $DEBUG
	#			puts @sorts.last.show
	#		end
	#	end
	#end
	def loadAllClass() # --- fini fonctionnel
		clss = Array.new
		clss = $bd.select('*','tblaclasses','')
		for cl in clss
			nom = cl[5]
			@idClasses[nom] = cl[0].to_i
			@classes.push(Classe.new(cl[0].to_i,cl[1].to_i,cl[2].to_i,cl[3].to_i,cl[4].to_i,cl[5],cl[6]))
			if $DEBUG
				puts @classes.last.show()
			end
		end
	end
	def loadAllRaces() # --- fini fonctionnel
		rcs = Array.new
		rcs = $bd.select('*','tblaraces','')
		for rc in rcs
			g = 0
			while @grandeurs[g].intIDGrandeur != rc[1].to_i
					g +=1
			end
			
			nom = rc[5]
			@idRaces[nom] = rc[0].to_i
			@races.push(Race.new(rc[0].to_i,@grandeurs[g],rc[2].to_i,rc[3].to_i,rc[4].to_i,rc[5],rc[6]))
			if $DEBUG
				puts @races.last.show()
			end
		end
	end
	def loadAllSkills()# --- fini fonctionnel
		cmps = Array.new
		cmps = $bd.select('*','tblacompetences','')
		for cmp in cmps
			att = 0
			flag = 0
			while flag == 0
				if $DEBUG
					puts @attributs[att].intIDAttribut.to_s + ' AND ' + cmp[1]
				end
				if @attributs[att].intIDAttribut == cmp[1].to_i 
					flag = 1
				elsif cmp[1].to_i == 0
					flag = 2
				else
					att += 1
				end
			end
			nom = cmp[2]
			@idCompetences[nom] = cmp[0].to_i
			if flag == 1
				@competences.push(Competence.new(cmp[0].to_i,
															   @attributs[att],
															   cmp[2],
															   cmp[3].to_i,
															   cmp[4].to_i,
															   cmp[5]))
			else
				@competences.push(Competence.new(cmp[0].to_i,
															   nil,
															   cmp[2],
															   cmp[3].to_i,
															   cmp[4].to_i,
															   cmp[5]))
			end
			if $DEBUG
				puts @competences.last.show()
			end
		end
	end
	def loadAllObjects() # --- fini fonctionnel
		objs = Array.new
		objs = $bd.select('*','tblaobjets','')
		for obj in objs
			
			g = 0
			tu = 0
			du = 0
			while @grandeurs[g].intIDGrandeur != obj[1].to_i
				g +=1
			end
			while @tempsUtilisation[tu].intIDTempsUtilisation != obj[2].to_i
				tu +=1
			end
			while @duree[du].intIDDuree != obj[3].to_i
				du +=1
			end
			nom = obj[8]
			@idObjets[nom] = obj[0].to_i
			@objets.push(Objet.new(obj[0].to_i,
			                                    @grandeurs[g],
												@tempsUtilisation[tu],
												@duree[du],
												obj[4].to_i,
												obj[5].to_i,
												obj[6].to_i,
												obj[7].to_i,
												obj[8],
												obj[9]))
			if $DEBUG
				puts @objets.last.show()
			end
		end
	end
	def loadAllGrandeurs() # --- fini fonctionnel*doit être appelé avant races
		lesGrandeurs = Array.new
		lesGrandeurs = $bd.select('*','tblzgrandeurs','')
		for grandeur in lesGrandeurs
			nom = grandeur[1]
			@idGrandeur[nom] = grandeur[0].to_i
			@grandeurs.push(Grandeur.new(grandeur[0].to_i,grandeur[1],grandeur[2].to_i,grandeur[3]))
			if $DEBUG
				puts @grandeurs.last.show()
			end
		end
	end
	def loadAllTempsUtilisation() # --- fini fonctionnel
		tempsutilisations = Array.new
		tempsutilisations = $bd.select('*','tblztempsutilisation','')
		for temputilisation in tempsutilisations
			nom = temputilisation[1]
			@idTempsUtilisation[nom] = temputilisation[0].to_i
			@tempsUtilisation.push(TempsUtilisation.new(temputilisation[0].to_i,temputilisation[1],temputilisation[2].to_i,temputilisation[3]))
			if $DEBUG
				puts @tempsUtilisation.last.show()
			end
		end
	end
	def loadAllDuree() # --- fini fonctionnel
		durees = Array.new
		durees = $bd.select('*','tblzdurees','')
		for d in durees
			nom = d[1]
			@idDuree[nom] = d[0].to_i
			@duree.push(Duree.new(d[0].to_i,d[1],d[2].to_i,d[3]))
			if $DEBUG
				puts @duree.last.show()
			end
		end
	end
	def loadAllAttributs()# --- fini fonctionnel
		attrs = Array.new
		attrs = $bd.select('*','tblzattributs','')
		for attr in attrs
			nom = attr[1]
			@idAttributs[nom] = attr[0].to_i
			@attributs.push(Attribut.new(attr[0].to_i,attr[1],attr[2],attr[3]))
			if $DEBUG
				puts @attributs.last.show()
			end
		end
		
	end
	def loadAllSexes() # --- fini fonctionnel
		sexs = Array.new
		sexs = $bd.select('*','tblzsexes','')
		for sex in sexs
			nom = sex[1]
			@idSexes[nom] = sex[0].to_i
			@sexes.push(Sexe.new(sex[0].to_i,sex[1],sex[2]))
			if $DEBUG
				puts @sexes.last.show()
			end
		end	
	end
	def loadAllAlignements() # --- fini fonctionnel
		aligns = Array.new
		aligns = $bd.select('*','tblzalignements','')
		for align in aligns
			nom = align[1]
			@idAlignements[nom] = align[0].to_i
			@alignements.push(Alignement.new(align[0].to_i,align[1],align[2]))
			if $DEBUG
				puts @alignements.last.show()
			end
		end
	end
	def loadAllYeux() # --- fini fonctionnel
	oeils = Array.new
	oeils = $bd.select('*','tblzyeux','')
		for oeil in oeils
			nom = oeil[1]
			@idYeux[nom] = oeil[0].to_i
			@yeux.push(Yeux.new(oeil[0].to_i,oeil[1]))
			if $DEBUG
				puts @yeux.last.show()
			end
		end
	end
	def loadAllCheveux() # --- fini fonctionnel*doit être appelé avant Perso
		chvx = Array.new()
		chvx = $bd.select('*','tblzcheveux','')
		for chv in chvx
			nom = chv[1]
			@idCheveux[nom] = chv[0].to_i
			@cheveux.push(Cheveux.new(chv[0].to_i,chv[1],chv[2]))
			if $DEBUG
				puts @cheveux.last.show()
			end
		end
	end
	def loadAllPerso()# --- fini fonctionnel
		ps = Array.new
		ps = $bd.select('*','tblapersonnages','')
		
		
		for p in ps
			sex = 0
			rac = 0
			ch = 0
			yx = 0
			al = 0
			while @sexes[sex].intIDSexe != p[1].to_i
				sex += 1
			end
			while @races[rac].intIDRace != p[2].to_i
				rac += 1
			end
			while @cheveux[ch].intIDCheveux != p[4].to_i
				ch += 1
			end
			while @yeux[yx].intIDYeux != p[5].to_i
				yx += 1
			end
			while @alignements[al].intIDYeux != p[9].to_i
				al += 1
			end
			nom = p[3]
			@idPersos[nom] = p[0].to_i
			@persos.push(Personnage.new(p[0].to_i,@sexes[sex],@races[rac],p[3],@cheveux[ch],@yeux[p[5]],p[6],p[7],p[8],@alignements[al],p[10],p[11],p[12],p[13],p[14],p[15]))
			if $DEBUG
				puts @persos.last.show()
			end
		end
		
	end
	def loadAllAlphabet() # --- fini fonctionnel * doit être appelé avant Langues
		als = Array.new
		als = $bd.select('*','tblzalphabets','')
		for al in als
			nom = al[1]
			@idAlphabets[nom] = al[0].to_i
			@alphabets.push(Alphabet.new(al[0].to_i,al[1],al[2]))
			if $DEBUG
				puts @alphabets.last.show()
			end
		end
	end
	def loadAllLangues()# --- fini fonctionnel
		langs = Array.new
		langs = $bd.select('*','tblzlangues','')
		
		for lang in langs
			alpha = 0
			
			while @alphabets[alpha].intIDAlphabet != lang[2].to_i
				alpha +=1
			end
			
			nom = lang[1]
			@idLangues[nom] = lang[0].to_i
			@langues.push(Langue.new(lang[0].to_i,lang[1],@alphabets[alpha],lang[3]))
			if $DEBUG
				puts @langues.last.show()
			end
		end
	end
	def loadAllEtapesAge()# --- fini fonctionnel
		etaps = Array.new
		etaps = $bd.select('*','tblzetapesage','')
		for etap in etaps
			nom = etap[1]
			@idEtapesAge[nom] = etap[0].to_i
			@etapesage.push(EtapeAge.new(etap[0].to_i,etap[1],etap[2]))
			if $DEBUG
				puts @etapesage.last.show()
			end
		end
	end
	def loadAllTypeObjets()# --- fini fonctionnel
		types = Array.new()
		types = $bd.select('*','tblztypesobjets','')
		for type in types
			nom = type[1]
			@idTypesObjets[nom] = type[0].to_i
			@typesobjets.push(TypeObjet.new(type[0].to_i,type[1],type[2].to_i,type[3]))
			if $DEBUG
				puts @typesobjets.last.show()
			end
		end
	end
	def loadAllCibles()# --- fini fonctionnel
		cibs = Array.new
		cibs = $bd.select('*','tblzcibles','')
		
		for cib in cibs
			nom = cib[1]
			@idCibles[nom] = cib[0].to_i
			@cibles.push(Cible.new(cib[0].to_i,cib[1],cib[2].to_i,cib[3]))
			if $DEBUG
				puts @cibles.last.show()
			end
		end
	end
	def loadAllTypesRaces()# --- fini fonctionnel
		traces = Array.new
		traces = $bd.select('*','tblztypesraces','')
		for trace in traces
			nom = trace[1]
			@idTypesRaces[nom] = trace[0].to_i
			@typesraces.push(TypeRace.new(trace[0].to_i,trace[1],trace[2]))
			if $DEBUG
				puts @typesraces.last.show()
			end
		end
	end
	def loadAllPortees()# --- fini fonctionnel
		ports = Array.new
		ports = $bd.select('*','tblzportees','')
		for port in ports
			nom = port[1]
			@idPortees[nom] = port[0].to_i
			@portees.push(Portee.new(port[0].to_i,port[1],port[2].to_i,port[3]))
			if $DEBUG
				puts @portees.last.show()
			end
		end
	end
	def loadAllTypesEffets() # --- fini fonctionnel
		teffets = Array.new
		teffets = $bd.select('*','tblztypeseffets','')
		for teffet in teffets
			nom = teffet[1]
			@idTypesEffets[nom] = teffet[0].to_i
			@typeseffets.push(TypeEffet.new(teffet[0].to_i,teffet[1],teffet[2].to_i,teffet[3]))
			if $DEBUG
				puts @typeseffets.last.show()
			end
		end
	end
	def loadAllTypesSorts()# --- fini fonctionnel
		tsorts = Array.new
		tsorts = $bd.select('*','tblztypessort','')
		for tsort in tsorts
			nom = tsort[1]
			@idTypesSorts[nom] = tsort[0].to_i
			@typessorts.push(TypeSort.new(tsort[0].to_i,tsort[1],tsort[2]))
			if $DEBUG
				puts @typessorts.last.show()
			end
		end
	end
	def loadAllComposantes()# --- fini fonctionnel
		cps = Array.new
		cps = $bd.select('*','tblzcomposantes','')
		for cp in cps
			nom = cp[1]
			@idComposantes[nom] = cp[0].to_i
			@composantes.push(Composante.new(cp[0].to_i,cp[1],cp[2]))
			if $DEBUG
				puts @composantes.last.show()
			end
		end
	end
	def loadAllEcolesMagie()# --- fini fonctionnel
		ems = Array.new
		ems = $bd.select('*','tblzecolemagie','')
		for em in ems
			nom = em[1]
			@idEcolesMagies[nom] = em[0].to_i
			@ecolesmagies.push(EcoleMagie.new(em[0].to_i,em[1],em[2].to_i,em[3]))
			if $DEBUG
				puts @ecolesmagies.last.show()
			end
		end
	end
	def loadAllTypesPersos()# --- fini fonctionnel
		tps = Array.new
		tps = $bd.select('*','tblztypespersos','')
		for tp in tps
			nom = i[1]
			@idTypesPersos[nom] = tp[0].to_i
			@typespersos.push(TypePerso.new(tp[0].to_i,tp[1],tp[2]))
			if $DEBUG
				puts @typespersos.last.show()
			end
		end
	end
	def loadAllDomaines()# --- fini fonctionnel
		dms = Array.new
		dms = $bd.select('*','tblzdomaines','')
		for dm in dms 
			nom = dm[1]
			@idDomaines[nom] = dm[0].to_i
			@domaines.push(Domaine.new(dm[0].to_i,dm[1],dm[2]))
			if $DEBUG
				puts @domaines.last.show()
			end
		end
	end
	def loadAllSpheresDieux()# --- fini fonctionnel
		sdx = Array.new
		sdx = $bd.select('*','tblzspheresdieux','')
		for sd in sdx
			nom = sd[1]
			@idSpheresDieux[nom] = sd[0].to_i
			@spheresdieux.push(SphereDieu.new(sd[0].to_i,sd[1],sd[2]))
			if $DEBUG
				puts @spheresdieux.last.show()
			end
		end
	end
	def loadAllTypesLanceurs()# --- fini fonctionnel
		tls = Array.new
		tls = $bd.select('*','tblztypeslanceur','')
		for tl in tls
			nom = tl[1]
			@idTypesLanceurs[nom] = tl[0].to_i
			@typeslanceurs.push(TypeLanceur.new(tl[0].to_i,tl[1],tl[2]))
			if $DEBUG
				puts @typeslanceurs.last.show()
			end
		end
	end
	def loadAllFomules()# --- fini fonctionnel
		fls = Array.new
		fls = $bd.select('*','tblzformules','')
		for fl in fls
			nom = fl[1]
			@idFormules[nom] = fl[0].to_i
			@formules.push(Formule.new(fl[0].to_i,fl[1],fl[2]))
			if $DEBUG
				puts @formules.last.show()
			end
		end
	end
	def loadAllArguments()# --- fini fonctionnel
		ags = Array.new
		ags = $bd.select('*','tblzarguments','')
		for ag in ags
			nom = ag[1]
			@idArguments[nom] = ag[0].to_i
			arguments.push(Argument.new(ag[0].to_i,ag[1],ag[2]))
			if $DEBUG
				puts arguments.last.show()
			end
		end
	end
	def loadAllNiveauxSorts()# --- fini fonctionnel
		nss = Array.new
		nss = $bd.select('*','tblzniveauxsorts','')
		for ns in nss
			nom = ns[1].to_s
			@idNiveauxSorts[nom] = ns[0].to_i
			@niveauxsorts.push(NiveauSort.new(ns[0].to_i,ns[1].to_i,ns[2]))
			if $DEBUG
				puts @niveauxsorts.last.show()
			end
		end
	end 
	def loadAllTypesPrerequis()# --- fini fonctionnel
		tps = Array.new
		tps = $bd.select('*','tblztypesprerequis','')
		for tp in tps
			nom = tp[1]
			@idTypesPrerequis[nom] = tp[0].to_i
			@typesprerequis.push(TypePrerequis.new(tp[0].to_i,tp[1],tp[2]))
			if $DEBUG
				puts @typesprerequis.last.show()
			end
		end
	end
	def loadAllTypesDons()# --- fini fonctionnel
		tds = Array.new
		tds = $bd.select('*','tblztypesdons','')
		for td in tds
			nom = td[1]
			@idTypesDons[nom] = td[0].to_i
			@typesdons.push(TypeDon.new(td[0].to_i,td[1],td[2].to_i,td[3]))
			if $DEBUG
				puts @typesdons.last.show()
			end
		end
	end
	#def loadAllDons()# --- fini fonctionnel
	#	ds = Array.new
	#	ds = $bd.select('*','tbladons','')
	#	for d in ds
	##		nom = d[1]
	#		@idDons[nom] = d[0].to_i
	#		@dons.push(Don.new(d[0].to_i,d[1],d[2]))
	#		if $DEBUG
	#			puts @dons.last.show()
	#		end
	#	end
	#end
	#-------------------------------- créations des listes de valeurs de retour
	def getClassList()
		namecl = Array.new
		for cl in @classes
			namecl.push(cl.txtNomClasse)
		end
		return namecl
	end
	def getRacesList()
		namerc = Array.new
		for rc in @races
			namerc.push(rc.txtNomRace)
		end
		return namerc
	end
	def getSexesList()
		namesx = Array.new
		for sx in @sexes
			namesx.push(sx.txtNomSexe)
		end
		return namesx
	end
	def getAlignementsList()
		nameal = Array.new
		for al in @alignements
			nameal.push(al.txtAlignement)
		end
		return nameal
	end
	def getAttribList()
		nameat = Array.new
		for at in @attributs
			nameat.push(at.txtNomAttribut)
		end 
		return nameat
	end
	def getYeuxList()
		nameyx = Array.new
		
		for yx in @yeux
			nameyx.push(yx.txtNomYeux)
		end
		return nameyx
	end
	def getCheveuxList()
		namechvx = Array.new
		for chvx in @cheveux
			namechvx.push(chvx.txtNomCheveux)
		end
		return namechvx
	end
end

$manuel = DonneesManuel.new()
