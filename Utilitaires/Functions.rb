# Functions.rb
########################################
# Par Jean-Michel Beauvais
# Date : 6 Mai 2011
########################################

module DataFuncs
	# Cr�ation des donn�es Core
	def DataFuncs.CreateDataVariables
		logging 'Creating Data Variables...'
		#$Classes
		#$Races
		return
	end

	# Acquisition des donn�es Core existantes. Retourne Vrai si les donn�es existent.
	def DataFuncs.GetDataVariables
		logging 'Getting existing data from file...'
		#$CoreDataFile
		#$DataClasses
		#$DataRaces
		return true
	end

	# V�rification des donn�es Core avec les donn�es existantes. Retourne Vrai si les donn�es sont identiques.
	def DataFuncs.CompareData
		logging 'Comparing created data with existing data...'
		#$Classes
		#$Races
		#$DataClasses
		#$DataRaces
		return true
	end

	# Enregistre les donn�es Core
	def DataFuncs.SaveData
		logging 'Saving created data on existing data...'
		#$Classes
		#$Races
		return
	end
end