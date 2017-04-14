{CompositeDisposable} = require 'atom'
HixEditor = require './hix-editor'

module.exports = Hix =
	subscriptions: null

	activate: (state) ->
		# events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
		@subscriptions = new CompositeDisposable

		# register command that toggles this view
		@subscriptions.add atom.commands.add 'atom-workspace', 'hix:toggle': => @toggle()

	deactivate: ->
		@subscriptions.dispose()

	serialize: -> {}

	toggle: ->
		pane = atom.workspace.getActivePane();
		if not pane
			console.log 'not pane'
			return
		return if not pane

		activeItem = pane.getActiveItem()
		index = pane.getActiveItemIndex()
		if activeItem.getText? || activeItem.getPath?
			if activeItem.hixEditor?
				activeItem.hixEditor.revert()
				delete activeItem.hixEditor
			else
				activeItem.hixEditor = new HixEditor activeItem, pane
