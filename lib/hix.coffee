HixView = require './hix-view'
{CompositeDisposable} = require 'atom'

module.exports = Hix =
	hixView: null
	modalPanel: null
	subscriptions: null

	activate: (state) ->
		@hixView = new HixView(state.hixViewState)
		@modalPanel = atom.workspace.addModalPanel(item: @hixView.getElement(), visible: false)

		# Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
		@subscriptions = new CompositeDisposable

		# Register command that toggles this view
		@subscriptions.add atom.commands.add 'atom-workspace', 'hix:toggle': => @toggle()

	deactivate: ->
		@modalPanel.destroy()
		@subscriptions.dispose()
		@hixView.destroy()

	serialize: ->
		hixViewState: @hixView.serialize()

	toggle: ->
		console.log 'Hix was toggled!'

		if @modalPanel.isVisible()
			@modalPanel.hide()
		else
			@modalPanel.show()
