{CompositeDisposable} = require 'atom'
HixEditor = require './hix-editor'

module.exports = Hix =
	hixView: null
	modalPanel: null
	subscriptions: null

	activate: (state) ->
		# events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
		@subscriptions = new CompositeDisposable

		# register command that toggles this view
		@subscriptions.add atom.commands.add 'atom-workspace', 'hix:toggle': => @toggle()

		# register our view provider
		atom.views.addViewProvider HixEditor, HixEditor.dispenseViewProvider

	deactivate: ->
		@subscriptions.dispose()

	serialize: -> {}

	hasTextEditor: (pane) ->
		return true for item in pane.getItems() when item instanceof TextEditor
		return false

	toggle: ->
		pane = atom.workspace.getActivePane();
		return if not pane

		activeItem = pane.getActiveItem()
		index = pane.getActiveItemIndex()
		if activeItem.getText? # DepCop suggests this is the correct way (lol js)
			hixEditor = new HixEditor activeItem

			# Pane will active the previous item when an item is removed
			pane.addItem hixEditor, index

			# We "moved" it (so it doesn't get destroyed)
			pane.removeItem activeItem, yes
			atom.workspace.paneContainer.removedPaneItem activeItem # hax
		else if activeItem instanceof HixEditor
			textEditor = activeItem.getEditor()

			pane.addItem textEditor, index

			# This time, dispose of it.
			pane.removeItem activeItem, no
