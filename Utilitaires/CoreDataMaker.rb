# CoreDataMaker.rb
########################################
# Par Jean-Michel Beauvais
# Date : 6 Mai 2011
########################################

begin
	
	require 'rubyscript2exe'

	$COMPILING = RUBYSCRIPT2EXE.is_compiling? # Indicateur de compilation.
	$COMPILING.freeze # Transforme la variable en constante.

	$COMPILED = RUBYSCRIPT2EXE.is_compiled? # Indicateur d'exécution dans le .exe
	#$COMPILED = true # Indicateur d'exécution dans le .exe
	$COMPILED.freeze # Transforme la variable en constante.
	
	if $COMPILED
		$stdout = $stderr = File.new(ENV['TEMP'] + "\\DOT.CoreDataMaker.#{Process.pid}.log", 'w')
	elsif $COMPILING
		$stdout = $stderr = File.new(ENV['TEMP'] + '\DOT.CoreDataMaker.COMPILE.log', 'w')
	else
		$stdout = $stderr = File.new(ENV['TEMP'] + '\DOT.CoreDataMaker.TRACE.log', 'w')
	end
	
	# Déclaration des variables des données Core
	$Classes
	$Races

	# Déclaration des variables des données Core Existantes
	$DataClasses
	$DataRaces

	# Autres variables importantes
	$CoreDataFile
	
	require '..\Sources\Utilities.rb'
	require 'Functions.rb'
	
	if $COMPILING
		# Options de compilation
		RUBYSCRIPT2EXE.rubyw = true # Sans console
		#RUBYSCRIPT2EXE.tk = true # Inclure Tk
	end
	
	DataFuncs.CreateDataVariables
	
	if DataFuncs.GetDataVariables
		if !DataFuncs.CompareData
			DataFuncs.SaveData
		end
	else
		DataFuncs.SaveData
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
		logging 'CoreDataMaker was terminated by a fatal error'
	end
else
	logging 'CoreDataMaker ended successfully.'
end

exit