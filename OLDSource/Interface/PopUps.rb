# #######################################################################
# 
# Permet l'affichage de messages ou de demandes de confirmation.
# 
# #######################################################################

# Types de fenêtres pop-up
module PUType
	DEFAULT = 0b000000001
	OK      = DEFAULT
	CANCEL  = 0b000000010
	YES     = 0b000000100
	NO      = 0b000001000
	APPLY   = 0b000010000
	RETRY   = 0b000100000
	ABORT   = 0b001000000
	
	Critical    = 0b010000000
	Information = 0b100000000
	Warning     = 0b110000000
	
	OkOnly           = DEFAULT
	OkCancel         = OK    + CANCEL
	OkApplyCancel    = OK    + APPLY + CANCEL
	YesNo            = YES   + NO
	YesNoCancel      = YES   + NO    + CANCEL
	RetryAbortCancel = RETRY + ABORT + CANCEL
end

#alias puCritical    PUType::Critical
#alias puInformation PUType::Information
#alias puWarning     PUType::Warning

#alias puOk               PUType::OkOnly
#alias puOkCancel         PUType::OkCancel
#alias puOkApplyCancel    PUType::OkApplyCancel
#alias puYesNo            PUType::YesNo
#alias puYesNoCancel      PUType::YesNoCancel
#alias puRetryAbortCancel PUType::RetryAbortCancel

# Base d'une fenêtre pop-up
class PopUp < Qt::Dialog
	# Flux
	signals 'answer(int)'
	slots 'hide()'
	
	#attr_reader :dispoPrincipale
	def initialize
		super
		
		# Paramètres du dialogue
		setWindowTitle(tr('JeRoFa')) # Titre de la fenêtre
		setLayout(@dispoPrincipale)  # Placer la disposition
		setModal(true)               # Rendre la fenêtre modale
		setSizeGripEnabled(false)    # Cacher l'icône de redimensionnement
		#setFixedSize(sizeHint)       # Rendre la fenêtre non-dimensionnable
		
		connect(self, SIGNAL('answer(int)'), self, SLOT('hide()'))
	end
	
	def setDispoPrin
		@dispoPrincipale = Qt::GridLayout.new()
	end
	
	def fixSize
		setFixedSize(sizeHint)       # Rendre la fenêtre non-dimensionnable
	end
	
	def hide()
		super
	end
end

# Seulement Ok
class DefaultPU < PopUp
	# Flux
	slots 'cmd1()','cmd2()','cmd3()'
	
	def initialize
		setDispoPrin
		
		@lblMessage = Qt::Label.new()
		@lblMessage.setWordWrap(false)
		@lblMessage.setMaximumWidth(MAIN_MIN_WIDTH/2)
		@lblMessage.setAlignment(Qt::AlignCenter)
		
		@dispoBoutons = Qt::HBoxLayout.new()
		
		@cmdBouton1 = Qt::PushButton.new()
		@cmdBouton2 = Qt::PushButton.new()
		@cmdBouton3 = Qt::PushButton.new()
		
		@cmdBouton1.hide()
		@cmdBouton2.hide()
		@cmdBouton3.hide()
		
		@typeBouton1 = 0
		@typeBouton2 = 0
		@typeBouton3 = 0
		
		@dispoBoutons.addWidget(@cmdBouton1)
		@dispoBoutons.addWidget(@cmdBouton2)
		@dispoBoutons.addWidget(@cmdBouton3)
		
		@dispoPrincipale.addWidget(@lblMessage, 0, 0, 1, 2)
		@dispoPrincipale.addLayout(@dispoBoutons, 1, 1)
		@dispoPrincipale.setColumnStretch(0,1)
		
		super
		
		connect(@cmdBouton1, SIGNAL('clicked()'), self, SLOT('cmd1()'))
		connect(@cmdBouton2, SIGNAL('clicked()'), self, SLOT('cmd2()'))
		connect(@cmdBouton3, SIGNAL('clicked()'), self, SLOT('cmd3()'))
		
		connect(self, SIGNAL('answer(int)'), self, SLOT('close()'))
		
		#setLeftButton(PUType::YES)
		#setMidButton(PUType::NO)
		#setRightButton(PUType::CANCEL)
	end
	
	def setMessage(strMessage)
		#if @lblMessage.text != ''
		#	return
		#end
		
		@lblMessage.setText(strMessage)
		#setFixedSize(sizeHint)       # Rendre la fenêtre non-dimensionnable
	end
	
	def setLeftButton(intType)
		case intType
		when PUType::OK
			@cmdBouton1.show()
			@cmdBouton1.setText(tr('Ok'))
		when PUType::YES
			@cmdBouton1.show()
			@cmdBouton1.setText(tr('Oui'))
		when PUType::RETRY
			@cmdBouton1.show()
			@cmdBouton1.setText(tr('Recommencer'))
		else
			@cmdBouton1.hide()
			intType = 0
		end
		
		@typeBouton1 = intType
	end
	
	def setMidButton(intType)
		case intType
		when PUType::NO
			@cmdBouton2.show()
			@cmdBouton2.setText(tr('Non'))
		when PUType::ABORT
			@cmdBouton2.show()
			@cmdBouton2.setText(tr('Abandonner'))
		when PUType::CANCEL
			@cmdBouton2.show()
			@cmdBouton2.setText(tr('Annuler'))
		else
			@cmdBouton2.hide()
			intType = 0
		end
		
		@typeBouton2 = intType
	end
	
	def setRightButton(intType)
		case intType
		when PUType::CANCEL
			@cmdBouton3.show()
			@cmdBouton3.setText(tr('Annuler'))
		when PUType::APPLY
			@cmdBouton3.show()
			@cmdBouton3.setText(tr('Appliquer'))
		else
			@cmdBouton3.hide()
			intType = 0
		end
		
		@typeBouton3 = intType
	end
	
	def cmd1
		#puts @typeBouton1.to_s
		emit answer(@typeBouton1)
	end
	
	def cmd2
		#puts @typeBouton2.to_s
		emit answer(@typeBouton2)
	end
	
	def cmd3
		#puts @typeBouton3.to_s
		emit answer(@typeBouton3)
	end
end

class MessageOk < DefaultPU
	def initialize(message)
		super()
		
		setLeftButton(PUType::OK)
		#setMidButton(PUType::NO)
		#setRightButton(PUType::CANCEL)
		setMessage(message)
		show()
		fixSize()
	end
end

class MessageConfirm < DefaultPU
	def initialize
		super
		
		setLeftButton(PUType::OK)
		#setMidButton(PUType::NO)
		setRightButton(PUType::CANCEL)
	end
end

#class MessageBox < Qt::Object
#	# Flux
#	slots 'answered(int)'
#	
#	attr_reader :intLastAnswer
#	
#	def initialize
#		super
#	end
#	
#	def MessageBox.open()
#		intLastAnswer = 0
#		@pop = DefaultPU.new()
#		@pop.setMessage('TESTING IT')
#		@pop.show()
#	end
#	
#	def MessageBox.lastAnswer()
#		return intLastAnswer
#	end
#end

#MsgBox = MessageBox.methods('MessageBox.open')