# init.rb
########################################
# Par Jean-Michel Beauvais
# En date du 16 Mars 2011
########################################
# Historique
# ----------
#
# 2011.03.24 - Jean-Michel Beauvais
# 	Ajout de la trace lorsque pas compilé.
#
# 2011.04.01 - Jean-Michel Beauvais
# 	Trace/Journal dans le dossier temporaire du système.
#
# 2011.04.08 - Jean-Michel Beauvais
# 	Gestion des erreurs fatales.

begin
	require 'tk'
	require 'rubyscript2exe'

	$COMPILING = RUBYSCRIPT2EXE.is_compiling? # Indicateur de compilation.
	$COMPILING.freeze # Transforme la variable en constante.
	
	$COMPILED = RUBYSCRIPT2EXE.is_compiled? # Indicateur d'exécution dans le .exe
	#$COMPILED = true # Indicateur d'exécution dans le .exe
	$COMPILED.freeze # Transforme la variable en constante.

	if $COMPILED
		$stdout = $stderr = File.new(ENV['TEMP'] + "\\DOT.#{Process.pid}.log", 'w')
	elsif $COMPILING
		$stdout = $stderr = File.new(ENV['TEMP'] + '\DOT.COMPILE.log', 'w')
	else
		$stdout = $stderr = File.new(ENV['TEMP'] + '\DOT.TRACE.log', 'w')
	end

	TkOption.add('*tearOff', 0) # Retire l'option dans les menus d'afficher le dit menu dans une fenêtre à part.

	require 'Utilities.rb'
	require 'ErrorCodes.rb'
	require 'Classes.rb'
	require 'Interface.rb'

	if $COMPILING
		# Options de compilation
		RUBYSCRIPT2EXE.rubyw = true # Sans console
		RUBYSCRIPT2EXE.tk = true # Inclure Tk
	else
		Tk.mainloop
	end
rescue
	puts ''
	puts '---------------------FATAL_ERROR---------------------'
	puts ''
	puts $!.message
	puts ''
	puts $!.backtrace.join("\n")
	puts ''
	puts '-----------------------------------------------------'
	puts ''
	
	begin
		logging 'DOT was terminated by a fatal error'
	end
else
	logging 'DOT ended successfully.'
end

exit