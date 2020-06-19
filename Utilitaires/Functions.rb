# Functions.rb
########################################
# Par Jean-Michel Beauvais
# Date : 6 Mai 2011
########################################

module DataFuncs
	# Création des données Core
	def DataFuncs.CreateDataVariables
		logging 'Creating Data Variables...'
		#$Classes
		#$Races
		return
	end

	# Acquisition des données Core existantes. Retourne Vrai si les données existent.
	def DataFuncs.GetDataVariables
		logging 'Getting existing data from file...'
		#$CoreDataFile
		#$DataClasses
		#$DataRaces
		return true
	end

	# Vérification des données Core avec les données existantes. Retourne Vrai si les données sont identiques.
	def DataFuncs.CompareData
		logging 'Comparing created data with existing data...'
		#$Classes
		#$Races
		#$DataClasses
		#$DataRaces
		return true
	end

	# Enregistre les données Core
	def DataFuncs.SaveData
		logging 'Saving created data on existing data...'
		#$Classes
		#$Races
		return
	end
end