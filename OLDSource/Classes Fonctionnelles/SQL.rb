require 'MySql'
require 'Qt4'

class IniSQL
	attr_reader :blnRefused
	attr_reader :errMess
	attr_reader :blnFonctionnel
	def initialize(serveur = 'localhost', username = 'root', password = '', database = '')
		@Serveur = serveur
		@UserName = username
		@Password = password
		@Database = database
		@blnRefused = false
		@blnFonctionnel = false
		
		begin
			@connexion = Mysql::new(@Serveur,@UserName,@Password,@Database)
		rescue Errno::ECONNREFUSED
			@blnRefused = true
			@errMess = 'Connexion refusée.'
		rescue SocketError
			@errMess = 'La destination n\'existe pas.'
		rescue Errno::ETIMEDOUT
			@errMess = 'Le serveur ne réponds pas.'
		else
			buildDb()
			@connexion.select_db('JeRoFa')
			@blnFonctionnel = true
			@errMess = ''
		end
	end
	
	def select(strFields, strTable, strCondition)
		if @blnRefused || !@blnFonctionnel
			return nil
		end
		
		strSQL = 'SELECT ' + strFields + ' FROM ' + strTable
		
		if strCondition != ''
			strSQL += ' WHERE ' + strCondition
		end
		
		strSQL += ';'
		return @connexion.query(strSQL)
	end
	
	def update(strTable, strChanges, strCondition)
		if @blnRefused || !@blnFonctionnel
			return nil
		end
		
		strSQL = 'UPDATE ' + strTable + ' SET ' + strChanges
		
		if strCondition != ''
			strSQL += ' WHERE ' + strCondition
		end
		
		strSQL += ';'
		@connexion.real_query(strSQL)
	end
	
	def insert(blnReplace, strTable, strFields, *strValues)
		if @blnRefused || !@blnFonctionnel
			return nil
		end
		
		if blnReplace
			strSQL = 'REPLACE '
		else
			strSQL = 'INSERT '
		end
		
		strSQL += 'INTO ' + strTable + ' ('+ strFields + ') VALUES '
		
		for value in strValues
			if strSQL[-2, 1] == 'S'
				strSQL += '(' + value + ')'
			else
				strSQL += ', (' + value + ')'
			end
		end
		
		strSQL += ';'
		#puts strSQL
		@connexion.real_query(strSQL)
	end
	
	def delete(strTable, strCondition)
		if @blnRefused || !@blnFonctionnel
			return nil
		end
		
		strSQL = 'DELETE FROM ' + strTable
		
		if strCondition != ''
			strSQL += ' WHERE ' + strCondition
		end
		
		strSQL += ';'
		@connexion.real_query(strSQL)
	end
	
private
	def buildDb
		if $DEBUG
			puts '---------------------BUILDING DATABASE---------------------'
		end
		
		sqlFile = File.new('Ressources/InitDb.sql', 'r')
		query = ''
		ligne = 0
		
		for line in sqlFile.readlines
			ligne += 1
			
			if $DEBUG
				puts ligne.to_s + ' - ' + line.to_s
			end
			
			if !(line[0,2].to_s == '--')
				query += line
				
				if $DEBUG
					puts 'QUERY IS NOW : {' + "\n" + query + "\n" + '}'
				end
				
				if line[-2,1].to_s == ';'
					begin
						@connexion.real_query(query)
						
						if $DEBUG
							puts 'EXECUTE : ' + query
						end
					rescue
						if $DEBUG
							puts 'Erreur dans l\'instruction suivante a la ligne ' + ligne.to_s
							puts '----------'
							puts query
							puts '----------'
						end
					end
					
					query = ''
				end
			end
		end
	end
end

#		test = IniSQL.new()
#
#		if test.blnRefused
#			puts 'Veuillez installer XAMPP et demarrer le serveur SQL.'
#		end

$bd = IniSQL.new()