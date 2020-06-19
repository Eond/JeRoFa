# Interface.rb
########################################
# Squelette par Jean-Michel Beauvais
# En date du 25 Mars 2011
########################################
# Historique
#
# 2011.03.28 - Jean-Michel Beauvais
# 	Ajout de commentaires.
# 	Contrôle du contenu.
# 2011.04.15 - Jean-François Brun
# 	Ajout de menus
#2011.04.29 - Jean-Michel Beauvais , Jean-François Brun
# 	Finalisation du menu ABOUT
#	Ajout de RadioBox dans le contenu
#	Ajout de variable du type d'utilisateur
#	Ajout de lien entre RadioBox et Application
#2011.05.09 - Jean-François Brun
#	Ajout de désactivation\réactivation de la boite adresse dépendament de la position du bouton radio
#	Ajout de distinction DM/PC
#	Début de création des pages de DM/PC
# --------------------------------------------------------------
# Main Window
# --------------------------------------------------------------
# Fenêtre principale de l'application.

# Constantes du contenu.
# ----------------------

MAIN_LOGIN = 100
MAIN_DM = 101
MAIN_PC = 199
MAIN_TEST  = 199

class GameWindow < TkRoot
	# Variables
	attr_reader   :content_id       # Numéro du contenu actuel.
	attr_reader   :varConnectAddress # Adresse de connexion
	attr_reader   :varUsertype      # Type d'utilisateur
	attr_accessor :varUsername      # Nom de connexion de l'utilisateur.
	
	# Méthodes
	def initialize(*args)
		super
		#iconimage('img\LOGO\logo_16x.bmp')
		
		@contentFrame     = TkFrame.new(self)
		@varUsername      = TkVariable.new
		@varConnectAddress = TkVariable.new
		@varUsertype      = TkVariable.new
		makeMenus
		content_id = 0
		changeContent(MAIN_LOGIN)
	end
	
	def changeContent(newContentId)
		# Efface les anciens contrôles de la fenêtre et appel la méthode requise pour afficher ke nouveau contenu.
		# newContentId : Numéro du nouveau contenu à afficher
		
		logging 'Changement du contenu pour le contenu #' + newContentId.to_s
		
		begin
			if !contentExists?(newContentId)
				fail DOTError.new(Error::ContentMissing)
			end
			
			if @content_id == newContentId
				fail DOTError.new(Error::ContentRecall)
			end
			
			case @content_id
			when MAIN_LOGIN
				dismantleLogin
			when MAIN_TEST
				dismantleTest
			when MAIN_DM
				dismantleDM
			#when MAIN_PC
			#	dismantlePC
			end
			
			@content_id = newContentId
			
			case @content_id
			when MAIN_LOGIN
				makeLogin
			when MAIN_TEST
				makeTest
			when MAIN_DM
				makeDM
			#when MAIN_PC
			#	makePC
			end
		rescue DOTError => ctrlErr # Erreur contrôlée
			logging ctrlErr.print
			
			if ctrlErr.errnum == Error::ContentMissing # Le contenu n'est pas bon.
				unless newContentId == MAIN_LOGIN # Seulement si le contenu demandé n'était pas le login.
					logging 'Force l\'écran de login.'
					newContentId = MAIN_LOGIN
					retry
				end
			elsif ctrlErr.errnum == Error::ContentRecall # Le contenu est déjà à l'écran
				# Indiquer qu'il faut rafraîchir l'affichage
			end
			
			raise
		rescue
			logging 'Uncontrolled erreur caught while changing content. (' + $! + ')'
			raise
		end
	end
	
	# Méthodes privées
	# ----------------
	
	def makeMenus
		# Construit la barre de menus du haut de la fenêtre.
		
		# Barre de menu
		# -------------------

		@menus = TkMenu.new()

		# Fichier
		@file = TkMenu.new(@menus)
		@file.add('command',
				 'label'=>'Quit',
				 'command'=>proc {
					$GameWindow.destroy
				 }
		)
		@menus.add('cascade',
				  'menu'=>@file,
				  'label'=>'File'
		)

		# Manuel
		@manual = TkMenu.new(@menus)
		@manual.add('command',
				   'label'=>'Manual window',
				   'command'=>proc {
					toggleManual
				   }
		)
		@manual.add('command',
				   'label'=>'TESTING OPEN',
				   'command'=>proc {
					filename = Tk::getOpenFile
				   }
		)
		@manual.add('command',
				   'label'=>'TESTING SAVE',
				   'command'=>proc {
					filename = Tk::getSaveFile
				   }
		)
		@manual.add('command',
				   'label'=>'TESTING CHOOSE DIR',
				   'command'=>proc {
					filename = Tk::chooseDirectory
				   }
		)
		@menus.add('cascade',
				  'menu'=>@manual,
				  'label'=>'Manual'
		)
		# À propos
		@help = TkMenu.new(@menus)
	
		@help.add('command',
				 'label'=> 'About',
				 'command'=> proc {
					toggleAbout(false)
				 }
		)
		@menus.add('cascade',
				  'menu'=>@help,
				  'label'=>'Help'
		)
		# Affecter les menus à la fenêtre
		menu(@menus)
	end
	
	private :makeMenus
	
	

	
	def contentExists?(contentId)
		# Indique si oui ou non le numéro fournit est valide.
		# contentId : numéro à vérifier
		
		case(contentId)
		when MAIN_LOGIN, MAIN_TEST, MAIN_DM, MAIN_PC
			return true
		else
			return false
		end
	end
	
	private :contentExists?
	
	def makeLogin
		# Construit le contenu
		username = TkEntry.new(@contentFrame)
		address = TkEntry.new(@contentFrame)
		
		username.textvariable(@varUsername)
		address.textvariable(@varConnectAddress)
		
		lblUsername = TkLabel.new(@contentFrame) {
			text 'Username'
		}
		lblAddress = TkLabel.new(@contentFrame) {
			text 'Address'
		}
		btnConnexion = TkButton.new(@contentFrame) {
			text 'Connexion'
			command proc {
				
				logging 'CLICK Bouton Connexion'
				if $GameWindow.varUsertype == 1 
					
					logging 'Logging as Dungeon Master'
					$GameWindow.changeContent(MAIN_DM)
					
				else
				
					logging 'Logging as Player Character'
					$GameWindow.changeContent(MAIN_PC)
				
				end
				#$GameWindow.changeContent(MAIN_TEST)
				
			}
		}
		
		r1 = TkRadioButton.new(@contentFrame) {
			text 'Dungeon Master'
			#variable $GameWindow.varUsertype
			value 1
			command proc {				# quand le bouton radio DM est cliqué, lblAddress et son txtbox se désactivent 
				logging 'CLICK RADIO DM'
				lblAddress.state = 'disabled'
				address.state = 'disabled'
				logging 'Turned address to disabled '
			}
			
		}
		r1.variable(@varUsertype)
		
		r2 = TkRadioButton.new(@contentFrame) {
			text 'Player Character'
			#variable $GameWindow.varUsertype
			value 2
			command proc {				# quand le bouton radio PC est cliqué, lblAddress et son txtbox se réactivent
				logging 'CLICK RADIO PC'
				lblAddress.state = 'normal'
				address.state = 'normal'
				logging 'Turned address to normal '
			}
			
			
		}
		r2.variable(@varUsertype)
		
		TkGrid(lblUsername, username, r1, 'sticky'=>'w')
		TkGrid(lblAddress, address, r2, 'sticky'=>'w')
		TkGrid(btnConnexion, 'columnspan'=>'3')
		
		geometry('400x200')
		resizable(false, false)
		@contentFrame.pack
		
	end
	
	private :makeLogin
	
	def makeTest
		aTest = TkButton.new(@contentFrame) {
			type = 'TESTING'
			
			if $GameWindow.varUsertype == 1 
				type = 'Dungeon Master'
				#makeDMMenus
			elsif $GameWindow.varUsertype == 2
				type = ' Player Character'
				#makePlayerMenus
				
			else
				type = 'BAD'
			end 
			
			text 'Voici un test pour le contenu.('+$GameWindow.varUsername.value()+', '+type+'])'
			command proc {
				logging 'CLICK Bouton ecran test'
				$GameWindow.changeContent(MAIN_LOGIN)
			}
		}
		
		aTest.pack
		
		geometry('800x600')
		resizable(true, true)
		@contentFrame.pack('side'=>'top', 'fill'=>'both', 'expand'=>true)
	end
	
	private :makeTest
	
	def makeDM
		bLogOut = TkButton.new(@contentFrame) {
			text 'Logout'
			command proc {
				logging 'CLICK LogOut Button'
				$GameWindow.changeContent(MAIN_LOGIN)
			}
		}
		bLogOut.pack
		geometry('800x600')
		resizable(false, false)
		@contentFrame.pack('side'=>'top', 'fill'=>'both', 'expand'=>true)
	end
	
	private :makeDM
	
	def dismantle
		@contentFrame.destroy
		@contentFrame = nil
		@contentFrame = TkFrame.new(self)
	end
	
	private :dismantle
	
	def dismantleLogin
		#TkGrid(@lblUsername, @username, "sticky"=>"w")
		#TkGrid(@lblAddress, @address, "sticky"=>"w")
		#TkGrid(@btnConnexion, "columnspan"=>"2")
		dismantle
	end
	
	private :dismantleLogin
	
	def dismantleTest
		#@aTest = nil
		dismantle
	end

	private :dismantleTest
	
	def dismantleDM
		dismantle
	end
	
	def dismantlePC
		diamantle
	end
end

$GameWindow = GameWindow.new() {
	title 'D&D Online Tabletop'
}

#$GameWindow.iconbitmap('JeRoFa.bmp')

# Composantes de la fenêtre
# ----------------------------------

#testWindow = TkLabel.new($GameWindow) {
#	text "Test Window"
#}

#testShowManual = TkButton.new($GameWindow) {
#	text "Test Manual"
#	command proc {
#		toggleManual
#	}
#}

#testWindow.pack("side"=>"bottom", "anchor"=>"w")
#testShowManual.pack("side"=>"top", "fill"=>"y")

# --------------------------------------------------------------
# Manuel
# --------------------------------------------------------------

require 'Manuel.rb'
require 'APropos.rb'
