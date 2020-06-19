# errorCodes.rb
########################################
# Par Jean-Michel Beauvais
# En date du 28 Mars 2011
########################################
# Historique
# ----------
#
# 2011.04.05 - Jean-Michel Beauvais
# 	Finalisation de l'exemple d'utilisation.
# 	Ajout de la méthode 'print' à la classe 'DOTError'.

########################################
# Utilisation des erreurs
########################################
#
#
# Ajouter un bloque 'begin'/'end' autour de la zone possible d'erreur.
# Si on trouve une erreur dans le block, on fait 'fail DOTError.new(X)' où X est le numéro de l'erreur.
# Mettre une clause 'rescue DOTError => ctrlErr' pour tenter d'arranger une erreur connue.
# Mettre une clause 'rescue' pour voir qu'il y a une erreur qu'on ne contrôle pas.
# Si on peut arranger l'erreur, on fait 'retry'.
# Si on ne peut pas gerer l'erreur, on donne la gestion aux autres gestionnaires hors de notre block avec 'raise'.
# Si on veut exécuter du code quand il n'y a pas eu d'erreur, on mets une clause 'else'.
# Si on doit absolument effectuer du code après le block, on met une clause 'ensure'.
#
# ----- EXEMPLE -----
#
# begin
# 	code
# 	if uneErreur
# 		fail DOTError.new(Error::NoError)
# 	end
# rescue DOTError => ctrlErr
# 	logging ctrlErr.print
# 	gestionErreurSelonNumero
# 	if peuPasGererOuCorriger
# 		raise
# 	end
# 	if peutCorriger
# 		faireCorrections
# 		retry
# 	end
# rescue
# 	logging 'Uncontrolled erreur caught while DOINGSOMETHING. (' + $! + ')'
# 	raise
# else
# 	code
# ensure
# 	code
# end
#
########################################

class DOTError < StandardError
	attr_reader :errnum # Numéro d'erreur
	
	def initialize(number = -1)
		@errnum = number
		super()
	end
	
	def print
		return '(' + @errnum.to_s + ') ' + Error.description(errnum)
	end
end

# Module des codes d'erreur

module Error
	NoError        = 0    # Aucune erreur
	
	ContentMissing = 1001 # Quand le contenu de la fenêtre demandé n'existe pas.
	ContentRecall  = 1002 # Quand le contenu de la fenêtre demandé est déjà affiché.
	
	InvalidData    = 9001 # Lorsqu'un champs ne contient pas une donnée possible.
	MissingData    = 9002 # La donnée n'existe pas.
	
	def Error.description(code)
		case(code)
		when NoError
			return "No error was caught."
		when ContentMissing
			return "The requested content is missing."
		when ContentRecall
			return "The requested content is already shown."
		when InvalidData
			return "The information given is not valid."
		when MissingData
			return "The requested information doesn't exist."
		else
			return "Unknown error caught."
		end
	end
end

def ErrDesc(code)
	return Error.description(code)
end

if !$COMPILED
	logging '=====ERROR CODES TEST====='
	logging 'ERROR ' + Error::NoError.to_s + ' (NO ERROR)'
	logging ErrDesc(Error::NoError)
	logging 'ERROR ' + Error::ContentMissing.to_s + ' (CONTENT MISSING)'
	logging ErrDesc(Error::ContentMissing)
	logging 'ERROR ' + Error::ContentRecall.to_s + ' (CONTENT RECALL)'
	logging ErrDesc(Error::ContentRecall)
	logging 'ERROR ' + Error::InvalidData.to_s + ' (INVALID DATA)'
	logging Error.description(Error::InvalidData)
	logging 'ERROR ' + Error::MissingData.to_s + ' (MISSING DATA)'
	logging ErrDesc(Error::MissingData)
	logging 'ERROR XYZ (UNKNOWN ERROR)'
	logging Error.description('XYZ')
end