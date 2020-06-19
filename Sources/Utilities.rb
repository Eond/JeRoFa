# Utilities.rb
########################################
# Par Jean-Michel Beauvais
# En date du 25 Mars 2011
########################################
# Historique
# ----------
#
# 2011.04.05 - Jean-Michel Beauvais
# 	Étalement du timeStamp sur plusieurs lignes pour faciliter la lecture.

def logging(message = "MESSAGE WAS OMITTED")
	rightNow = Time.new
	
	timeStamp  = '['
	
	timeStamp += sprintf("%04i",rightNow.year) + '.'
	timeStamp += sprintf("%02i",rightNow.month) + '.'
	timeStamp += sprintf("%02i",rightNow.day) + ' - '
	
	timeStamp += sprintf("%02i",rightNow.hour) + ':'
	timeStamp += sprintf("%02i",rightNow.min) + ':'
	timeStamp += sprintf("%02i",rightNow.sec) + ']'
	
	puts timeStamp + ' ' + message.to_s
end